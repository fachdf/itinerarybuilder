using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ItineraryBuilder_Backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSequence : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Photo");

            migrationBuilder.EnsureSchema(
                name: "Places");

            migrationBuilder.CreateSequence<int>(
                name: "Id",
                schema: "Photo");

            migrationBuilder.CreateSequence<int>(
                name: "Id",
                schema: "Places");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropSequence(
                name: "Id",
                schema: "Photo");

            migrationBuilder.DropSequence(
                name: "Id",
                schema: "Places");
        }
    }
}
