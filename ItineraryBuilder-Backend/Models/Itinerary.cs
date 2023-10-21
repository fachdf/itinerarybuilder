

namespace ItineraryBuilder_Backend.Models
{
    public class Itinerary
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<ItineraryPlace>? ItineraryPlaces { get; set; }
    }

}
