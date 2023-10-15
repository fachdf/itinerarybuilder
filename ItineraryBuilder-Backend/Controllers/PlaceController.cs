using ItineraryBuilder_Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ItineraryBuilder_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlaceController : ControllerBase
    {
        private readonly ItineraryBuilderContext _context;

        public PlaceController(ItineraryBuilderContext context)
        {
            _context = context;
        }

        // GET: api/<PlaceController>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Place>>> GetPlaces()
        {
            if (_context.Places == null)
            {
                return NotFound();
            }
            return await _context.Places.ToListAsync();
        }

        // GET api/<PlaceController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Place>> GetPlace(int id)
        {
            if (_context.Places == null)
            {
                return NotFound();
            }
            var place = await _context.Places.FindAsync(id);

            if (place == null)
            {
                return NotFound();
            }

            return place;
        }

        // POST api/<PlaceController>
        [HttpPost]
        public async Task<ActionResult<Place>> PostPlace(
                                                        [FromBody] string name,
                                                        [FromBody] string address,
                                                        [FromBody] string description,
                                                        [FromBody] List<string> urls,
                                                        [FromBody] int visitTime
                                                        )
        {
            // Create a new place without adding it to the context
            var place = new Place
            {
                Name = name,
                Address = address,
                Description = description,
                VisitTime = visitTime,
                // Set other properties as needed
            };

            // Save changes to the context to generate the ID using the sequence
            await _context.SaveChangesAsync();

            // Add the place to the context
            _context.Places.Add(place);

            // Obtain the newly created Place's ID
            int placeId = place.Id;

            // Create new photos with the provided URLs and associate them with the place
            foreach (var url in urls)
            {
                var photo = new Photo { Url = url, PlaceId = placeId };
                place.Photos.Add(photo);
            }

            // Save changes to the database
            await _context.SaveChangesAsync();

            // Return a 201 Created response with the newly created Place
            return CreatedAtAction(nameof(GetPlace), new { id = placeId }, place);
        }


        // PUT api/<PlaceController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<PlaceController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
