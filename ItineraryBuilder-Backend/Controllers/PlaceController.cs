using ItineraryBuilder_Backend.Models;
using ItineraryBuilder_Backend.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Reflection;
using System.Text.Json;

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
            return await _context.Places.Include(p => p.Photos).ToListAsync();
        }

        // GET api/<PlaceController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Place>> GetPlace(int id)
        {
            if (_context.Places == null)
            {
                return NotFound();
            }
            var place = await _context.Places.Include(p => p.Photos).FirstOrDefaultAsync(p => p.Id == id);

            if (place == null)
            {
                return NotFound();
            }

            return place;
        }

        // POST api/<PlaceController>
        [HttpPost]
        public async Task<ActionResult<Place>> PostPlace([FromBody] PlaceCreateModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid input.");
            }

            // Create a Place instance from the input
            var place = new Place
            {
                Name = model.Name,
                Address = model.Address,
                Description = model.Description,
                VisitTime = model.VisitTime,
                Photos = new List<Photo>()
                // Add other properties as needed
            };

            // Create Photo instances and associate them with the Place
            if (model.Photos != null && model.Photos.Any())
            {
                foreach (var photoModel in model.Photos)
                {
                    var photo = new Photo
                    {
                        Url = photoModel.Url,
                    };
                    place.Photos.Add(photo);
                }
            }

            // Save the Place and its associated Photos to the database
            _context.Places.Add(place);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetPlace), new { id = place.Id }, place);
        }


        // PUT api/<PlaceController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult> PutPlace(int id, [FromBody] JsonElement input)
        {
            var place = await _context.Places
                .Include(p => p.Photos)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (place == null)
            {
                return NotFound();
            }

            var placeProperties = typeof(Place).GetProperties().Select(p => p.Name.ToLower()).ToList();

            // Iterate through the properties provided in the JSON input
            foreach (var property in input.EnumerateObject())
            {
                var propertyName = property.Name.ToLower();

                if (placeProperties.Contains(propertyName))
                {
                    // Update the property in the Place entity
                    var propertyInfo = typeof(Place).GetProperty(propertyName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                    if (propertyInfo != null)
                    {
                        var value = JsonSerializer.Deserialize(property.Value.GetRawText(), propertyInfo.PropertyType);
                        propertyInfo.SetValue(place, value);
                    }
                }
            }

            await _context.SaveChangesAsync();

            return Ok(place);
        }

        // DELETE api/<PlaceController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePlace(int id)
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

            _context.Places.Remove(place);

            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}
