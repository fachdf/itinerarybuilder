using System.Text.Json.Serialization;

namespace ItineraryBuilder_Backend.Models
{
    public class Photo
    {
        public int Id { get; set; }
        public string Url { get; set; }

        public int PlaceId { get; set; }
        [JsonIgnore]
        public Place Place { get; set; }
       
    }
}
