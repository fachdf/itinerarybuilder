using ItineraryBuilder_Backend.Models;
using ItineraryBuilder_Backend.ViewModels;
using Microsoft.AspNetCore.Identity;

namespace ItineraryBuilder_Backend.Services
{
    public interface IUserService
    {
        Task<UserManagerResponse> RegisterUserAsync(RegisterViewModel model);

    }

    public class UserService : IUserService
    {
        private UserManager<IdentityUser> _userManager;
        public UserService(UserManager<IdentityUser> userManager)
        {
            _userManager = userManager;
        }
        public async Task<UserManagerResponse> RegisterUserAsync(RegisterViewModel model)
        {
            if (model == null)
            {
                throw new NullReferenceException("Register Model Is Null");
            }

            if (model.Password != model.ConfirmPassword)
            {

                return new UserManagerResponse
                {
                    Message = ("Confirm Password Doesn't Match"),
                    IsSuccess = false
                };
            }

            var identityUser = new IdentityUser
            {
                Email = model.Email,
                UserName = model.Email
            };

            var result = await _userManager.CreateAsync(identityUser, model.Password);

            if (result.Succeeded)
            {
                // Send Email Confirmation

                return new UserManagerResponse
                {
                    Message = "User Created Successfully!",
                    IsSuccess = true
                };
            }

            return new UserManagerResponse
            {
                Message = "User did not created",
                IsSuccess = false,
                Errors = result.Errors.Select(e => e.Description)
            };
        }
    }
}