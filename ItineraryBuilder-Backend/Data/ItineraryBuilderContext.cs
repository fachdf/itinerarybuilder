using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ItineraryBuilder_Backend;
using ItineraryBuilder_Backend.Models;

public class ItineraryBuilderContext : DbContext
    {
        public ItineraryBuilderContext (DbContextOptions<ItineraryBuilderContext> options)
            : base(options)
        {
            
        }

        public DbSet<Place> Places { get; set; }
        public DbSet<Photo> Photos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasSequence<int>("Id", schema: "Photo")
                .StartsAt(1)
                .IncrementsBy(1);
            modelBuilder.HasSequence<int>("Id", schema: "Places")
                .StartsAt(1)
                .IncrementsBy(1);
    }
}
