import React from "react";
import FullCalendar from '@fullcalendar/react' 
import dayGridPlugin from '@fullcalendar/daygrid' 
import AddEventModal from'./AddEventModal'
import axios from "axios";
import moment from "moment/moment";
import './calendar.css'
import { Modal } from "antd";
import { useRef , useState , useEffect} from "react";
import { ExclamationCircleFilled } from "@ant-design/icons";
export default function (titleProduct){
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [events , setEvents] = useState([]);
  const { confirm } = Modal;

  useEffect(() => {

  
  }, [titleProduct.titleProduct]);

  const showDeleteConfirm = ({event,el}) => {
    confirm({
      title: 'Are you sure delete this task?',
      icon: <ExclamationCircleFilled />,
      content: 'Some descriptions',
      okText: 'Yes',
      okType: 'danger',
      cancelText: 'No',
      onOk() {
        
        const response = axios.delete('/api/calendar/delete-event?id='+event._def.extendedProps._id);
        event.remove()
      },
      onCancel() {
        console.log('Cancel');
      },
    });
  };

  const showModal = () => {
    console.log(isModalOpen)
    setIsModalOpen(true);
    console.log(isModalOpen)
  };
  const handleCancel = () => {
    setIsModalOpen(false);
  };
  const calendarRef = useRef (null);
  const onEventAdded = event => {
    let calendarApi = calendarRef.current.getApi()
    calendarApi.addEvent({
      start: moment(event.start).toDate(),
      end:moment(event.end).toDate(),
      title:event.title
    });
  };
  

  async function handleEventAdd(data){
    axios.post('/api/calendar/create-event',data.event)
  }

async function handleDatesSet(data){
 const response = await axios.get('/api/calendar/get-events?start='+moment(data.start).toISOString()+'&end='+moment(data.end).toISOString()+'&title='+titleProduct.titleProduct);
 setEvents(response.data)
}
    return (
      
        <section>
          <div style={{position:"relative",zIndex:0,margin:100}}>
  
    <FullCalendar 
        ref={calendarRef}
        plugins={[ dayGridPlugin ]}
        events={events}
        initialView="dayGridMonth"
        eventAdd={event=>handleEventAdd(event)}
        datesSet={(date)=>handleDatesSet(date)}
        editable={true}
        headerToolbar={{
          start: 'myCustomButton', 
          center: 'title',
          end: 'today prev,next'
        }}
        customButtons={{
        myCustomButton: {
            text: 'Add Event',
            click: function() {
              setIsModalOpen(true);
            },
        },
        }}
        eventClick={showDeleteConfirm}
        
        

      />
      </div>;


<AddEventModal style={{zIndex:30}} open={isModalOpen} onClose={handleCancel} onEventAdded={event=> onEventAdded(event)}/>
        </section>
        

    )
}