document.addEventListener("DOMContentLoaded", async () => {
  const urlParams = new URLSearchParams(window.location.search);
  const eventId = urlParams.get("eventId");

  if (!eventId) {
    console.error("❌ No event ID provided in URL");
    return;
  }

  try {
    const response = await fetch(`${window.location.origin}/ClubSphere/FetchEventDetailsServlet?eventId=${eventId}`);
    const data = await response.json();

    if (data.error) {
      console.error("❌ " + data.error);
      document.querySelector(".event-title").textContent = "Event Not Found";
      return;
    }

    console.log("✅ Event details:", data);

    // Update the event hero section
    document.querySelector(".event-title").textContent = data.title;
    document.querySelector(".event-badge").innerHTML = `<i class="fas fa-calendar-check me-2"></i>${data.status || "Upcoming"}`;
    document.querySelector(".club-name").innerHTML = `<i class="fas fa-users"></i>Organized by Club #${data.club_id}`;

    // Event Info
    const infoItems = document.querySelectorAll(".info-item .info-content p");
    infoItems[0].textContent = data.date;
    infoItems[1].textContent = data.time || "TBA";
    infoItems[2].textContent = data.venue;
    infoItems[3].textContent = data.category || "General";

    // Description
    const descDiv = document.querySelector(".description-text");
    descDiv.innerHTML = data.description || "No description available.";

  } catch (error) {
    console.error("❌ Error loading event:", error);
  }
});
    	