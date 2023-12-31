﻿using System.Text.Json.Serialization;

namespace ItineraryBuilder_Backend.Models
{
    public class Place
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Address { get; set; }
        public string? Description { get; set; }
        public string? UserId { get; set; }
        public string? GoogleMapUrl {  get; set; }  
        public List<Photo>? Photos { get; set; }
        [JsonIgnore]
        public List<ItineraryPlace>? ItineraryPlaces { get; set; }
        public Place() { }
    }
}
