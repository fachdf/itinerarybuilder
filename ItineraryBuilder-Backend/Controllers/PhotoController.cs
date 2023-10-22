using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using ItineraryBuilder_Backend.Models;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.AspNetCore.Authorization;
// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ItineraryBuilder_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class PhotoController : ControllerBase
    {
        private readonly ItineraryBuilderContext _context;

        public PhotoController(ItineraryBuilderContext context)
        {
            _context = context;
        }

        // GET: api/<PhotoController>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Photo>>> GetPhotos()
        {
            if(_context.Photos == null)
            {
                return NotFound();
            }
            return await _context.Photos.ToListAsync();
        }

        // GET api/<PhotoController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Photo>> GetPhoto(int id)
        {
            if (_context.Photos == null)
            {
                return NotFound();
            }
            var photo = await _context.Photos.FindAsync(id);

            if(photo == null) {
                return NotFound();
            }

            return photo;
        }

        // POST api/<PhotoController>
        [HttpPost]
        public async Task<ActionResult<Photo>> PostPhoto(Photo photo)
        {
            _context.Photos.Add(photo);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetPhoto), new { id = photo.Id }, photo);
        }

        // PUT api/<PhotoController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult> PutPhoto(int id, Photo photo)
        {
            if(id != photo.Id)
            {
                return BadRequest();
            }
            _context.Entry(photo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PhotoAvailable(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return Ok();
        }

        private bool PhotoAvailable(int id)
        {
            return (_context.Photos?.Any(x => x.Id == id)).GetValueOrDefault();
        }

        // DELETE api/<PhotoController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePhoto(int id)
        {
            if(_context.Photos == null)
            {
                return NotFound();
            }

            var photo = await _context.Photos.FindAsync(id);

            if(photo == null)
            {
                return NotFound();
            }

            _context.Photos.Remove(photo);

            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}
