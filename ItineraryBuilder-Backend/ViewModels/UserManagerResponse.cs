namespace ItineraryBuilder_Backend.ViewModels
{
    public class UserManagerResponse
    {
        public string Message { get; set; }
        public bool IsSuccess { get; set; }
        public DateTime? ExpireDate { get; set; }
        public IEnumerable<string> Errors { get; set; }

    }
}
