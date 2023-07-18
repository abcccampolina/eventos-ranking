import { Controller } from "stimulus"
import Calendar from "tui-calendar"
import "tui-calendar/dist/tui-calendar.css";
import '../packs/bootstrap-notify.js'

export default class extends Controller {

  calendar = null;
  connect() {
    if (this.data.has("actionForm")) {
      switch (this.data.get("actionForm")) {
        case "calendar": {
          this.onCalendar()
          console.log("Calendar load!")
          break
        }
        case "edit": {
          this.on_edit()
          break
        }
      }
    }
  }

  
  sortTable(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById("myTable");
    switching = true;
    //Set the sorting direction to ascending:
    dir = "asc"; 
    /*Make a loop that will continue until
    no switching has been done:*/
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.rows;
      /*Loop through all table rows (except the
      first, which contains table headers):*/
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        /*Get the two elements you want to compare,
        one from current row and one from the next:*/
        x = rows[i].getElementsByTagName("TD")[n];
        y = rows[i + 1].getElementsByTagName("TD")[n];
        /*check if the two rows should switch place,
        based on the direction, asc or desc:*/
        if (dir == "asc") {
          if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
            //if so, mark as a switch and break the loop:
            shouldSwitch= true;
            break;
          }
        } else if (dir == "desc") {
          if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
            //if so, mark as a switch and break the loop:
            shouldSwitch = true;
            break;
          }
        }
      }
      if (shouldSwitch) {
        /*If a switch has been marked, make the switch
        and mark that a switch has been done:*/
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
        //Each time a switch is done, increase this count by 1:
        switchcount ++;      
      } else {
        /*If no switching has been done AND the direction is "asc",
        set the direction to "desc" and run the while loop again.*/
        if (switchcount == 0 && dir == "asc") {
          dir = "desc";
          switching = true;
        }
      }
    }
  }


  onCalendar() {
    this.calendar = new Calendar('#calendar', {
      defaultView: 'week',
      taskView: true,
      template: {
        monthDayname: function (dayname) {
            return '<span class="calendar-week-dayname-name">' + dayname.label + '</span>';
          }
      }
    });
    this.loadSchedules()

  }

  loadSchedules() {
    this.calendar.createSchedules([{
            id: '1',
            calendarId: '1',
            title: 'Reunião de alinhamento diário',
            category: 'time',
            dueDateClass: '',
            start: '2020-05-20T17:30:00-03:00',
            end: '2020-05-20T18:00:00-03:00'
          }, {
            id: '2',
            calendarId: '1',
            title: 'Reunião de alinhamento diário',
            category: 'time',
            dueDateClass: '',
            start: '2020-05-21T17:30:00-03:00',
            end: '2020-05-21T18:00:00-03:00'
          }, {
            id: '4',
            calendarId: '1',
            title: 'Reunião de alinhamento diário',
            category: 'time',
            dueDateClass: '',
            start: '2020-05-22T17:30:00-03:00',
            end: '2020-05-22T19:00:00-03:00'
          }
    ]);
  }


  
  disconnect() {
    console.log("unload Dashboard");
  }
}