using ItineraryBuilder_Backend.Services;
using ItineraryBuilder_Backend.ViewModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ItineraryBuilder_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ItineraryBuilderContext _context;
        private IUserService _userService;

        public AuthController(IUserService userService, ItineraryBuilderContext context)
        {
            _userService = userService;
            _context = context;
        }


        // /api/auth/register
        [HttpPost("Register")]
        public async Task<IActionResult> RegisterAsync(RegisterViewModel model)
        {
            if(!ModelState.IsValid)
            {
                return BadRequest("Some properties are not valid");
            }

            var result = await _userService.RegisterUserAsync(model);

            if(result.IsSuccess)
            {
                return Ok(result); // Status Code 200
            }

            return BadRequest(result);
        }
    }
}
