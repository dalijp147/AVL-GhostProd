/*!
=========================================================
* Muse Ant Design Dashboard - v1.0.0
=========================================================
* Product Page: https://www.creative-tim.com/product/muse-ant-design-dashboard
* Copyright 2021 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/muse-ant-design-dashboard/blob/main/LICENSE.md)
* Coded by Creative Tim
=========================================================
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/
import {
  Row,
  Col,
  Card,
} from "antd";

import { useEffect,useState } from "react";
import { MapContainer, TileLayer, Marker ,Popup} from 'react-leaflet'
import L from 'leaflet'
import '../assets/styles/map.css'
import marker from '../assets/images/vippng.com-red-pin-png-1010455.png'
// const { RangePicker } = DatePicker;
// const { TextArea } = Input;
function MapComponent() {

  const ClientPosition = [36.806389 ,10.181667];
  return (
    <>
     
           <div className="tabled">
        <Row gutter={[24, 0]}>
          <Col xs="24" xl={24}>
            <Card
              bordered={false}
              className="criclebox tablespace mb-24"
              title="Authors Table"
              extra={
                <>
                

    
                </>
              }
            >
              
              <div className="table-responsive">
              <MapContainer center={ClientPosition} zoom={13} scrollWheelZoom={false}>
                 <TileLayer
                  attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                  url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                  />
                  <Marker position={ClientPosition}>
                  <Popup>
                   A pretty CSS3 popup. <br /> Ea sily customizable.
                   </Popup>
                    </Marker>
               </MapContainer>
              
              </div>
            </Card>

          </Col>
        </Row>
      </div>
    </>
  );
}

let DefaultIcon = L.icon(
 { 
  iconUrl: marker,
  iconSize: [18,45],  }
);
L.Marker.prototype.options.icon = DefaultIcon;

export default MapComponent;
