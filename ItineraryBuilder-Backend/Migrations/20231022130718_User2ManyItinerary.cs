using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ItineraryBuilder_Backend.Migrations
{
    /// <inheritdoc />
    public partial class User2ManyItinerary : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Itinerary",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_Itinerary_UserId",
                table: "Itinerary",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Itinerary_AspNetUsers_UserId",
                table: "Itinerary",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Itinerary_AspNetUsers_UserId",
                table: "Itinerary");

            migrationBuilder.DropIndex(
                name: "IX_Itinerary_UserId",
                table: "Itinerary");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Itinerary");
        }
    }
}
