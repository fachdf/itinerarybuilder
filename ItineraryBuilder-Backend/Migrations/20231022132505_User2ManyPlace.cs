﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ItineraryBuilder_Backend.Migrations
{
    /// <inheritdoc />
    public partial class User2ManyPlace : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Places",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Places_UserId",
                table: "Places",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Places_AspNetUsers_UserId",
                table: "Places",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Places_AspNetUsers_UserId",
                table: "Places");

            migrationBuilder.DropIndex(
                name: "IX_Places_UserId",
                table: "Places");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Places");
        }
    }
}
