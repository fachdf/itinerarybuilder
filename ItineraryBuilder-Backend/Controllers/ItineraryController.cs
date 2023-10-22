using ItineraryBuilder_Backend.Models;
using ItineraryBuilder_Backend.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Reflection;
using System.Security.Claims;
using System.Text.Json;

namespace ItineraryBuilder_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ItineraryController : Controller
    {
        private readonly ItineraryBuilderContext _context;

        public ItineraryController(ItineraryBuilderContext context)
        {
            _context = context;
        }

        // GET api/<ItineraryController>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Itinerary>>> GetItineraries()
        {
            var userId = HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier);

            if (_context.Itinerary == null)
            {
                return NotFound();
            }

            if (_context.Itinerary.Include(i => i.ItineraryPlaces) == null)
            {
                return await _context.Itinerary.ToListAsync();
            }
            return await _context.Itinerary.Where(i => i.UserId == userId).Include(i => i.ItineraryPlaces).ThenInclude(j => j.Place).ThenInclude(k => k.Photos).ToListAsync();

        }


        // GET api/<ItineraryController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Itinerary>> GetItinerary(int id)
        {
            var userId = HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (_context.Itinerary == null)
            {
                return NotFound();
            }

            var itinerary = await _context.Itinerary
                .Where(i => i.UserId == userId)
                .Include(i => i.ItineraryPlaces)
                .ThenInclude(j => j.Place)
                .ThenInclude(k => k.Photos)
                .FirstOrDefaultAsync(i => i.Id == id);

            if (itinerary == null)
            {
                return NotFound();
            }

            return itinerary;
        }


        // POST api/<ItineraryController>
        [HttpPost]
        public async Task<ActionResult<Itinerary>> PostItinerary(ItineraryCreateModel model)
        {
            if(model == null)
            {
                return BadRequest("Invalid input.");
            }

            var itinerary = new Itinerary
            {
                Name = model.Name,
                UserId = HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier)
            };

            _context.Itinerary.Add(itinerary);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetItinerary), new { id = itinerary.Id }, itinerary);
        }


        // PUT api/<PlaceController>/5
        [Route("AddPlaceToItinerary")]
        [HttpPut]
        public async Task<IActionResult> AddPlaceToItinerary([FromBody] ItineraryPlaceCreateModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid input.");
            }

            var itinerary = await _context.Itinerary.FirstOrDefaultAsync(i => i.Id == model.ItineraryId);
            var place = await _context.Places.FirstOrDefaultAsync(p => p.Id == model.PlaceId);


            if (itinerary != null && place != null)
            {
                // Create a ItineraryPlace instance from the input
                var itineraryPlace = new ItineraryPlace
                {
                    PlaceId = model.PlaceId,
                    ItineraryId = model.ItineraryId
                    // Add other properties as needed
                };

                itineraryPlace.Place = place;
                itineraryPlace.Itinerary = itinerary;
                // Add the ItineraryPlace to the Itinerary's collection
                if (itinerary.ItineraryPlaces == null)
                {
                    itinerary.ItineraryPlaces = new List<ItineraryPlace>();
                }
                
                itinerary.ItineraryPlaces.Add(itineraryPlace);

                // Add the ItineraryPlace to the Place's collection
                if (place.ItineraryPlaces == null)
                {
                    place.ItineraryPlaces = new List<ItineraryPlace>();
                }
                place.ItineraryPlaces.Add(itineraryPlace);

                await _context.SaveChangesAsync();

                return Ok("Place added to Itinerary successfully.");
            }

            return NotFound("Itinerary or Place not found.");
        }

        // PUT api/<PlaceController>/5
        [HttpPut("UpdateItineraryDetails")]
        public async Task<ActionResult> UpdateItineraryDetails([FromBody] ItineraryPlaceCreateModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid input.");
            }

            var existingItineraryPlace = await _context.ItineraryPlace.FirstOrDefaultAsync(ip => ip.ItineraryId == model.ItineraryId && ip.PlaceId == model.PlaceId);

            if (existingItineraryPlace == null)
            {
                // An ItineraryPlace with the same ItineraryId and PlaceId already exists
                return BadRequest("Object [ItineraryPlace] Not Found.");
            }

            // Update the properties of the existing ItineraryPlace
            existingItineraryPlace.Number = model.Number;
            existingItineraryPlace.VisitTime = model.VisitTime;
            existingItineraryPlace.IsVisited = model.IsVisited;

            // Iterate through the properties provided in the JSON input
            await _context.SaveChangesAsync();

            return Ok(existingItineraryPlace);
        }


    }
}
