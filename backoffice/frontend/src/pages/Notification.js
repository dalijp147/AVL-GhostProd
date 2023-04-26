import { Row, Col, Card, Table, Button ,Form,Input,Modal} from "antd";
import React, { useEffect, useState } from "react";
import axios from "axios";
import ModalComponent from "./modal";
import { PlusOutlined } from "@ant-design/icons";

const deletebtn = [
  <svg
    width='16'
    height='16'
    viewBox='0 0 20 20'
    fill='none'
    xmlns='http://www.w3.org/2000/svg'
    key={0}
  >
    <path
      fillRule='evenodd'
      clipRule='evenodd'
      d='M9 2C8.62123 2 8.27497 2.214 8.10557 2.55279L7.38197 4H4C3.44772 4 3 4.44772 3 5C3 5.55228 3.44772 6 4 6L4 16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V6C16.5523 6 17 5.55228 17 5C17 4.44772 16.5523 4 16 4H12.618L11.8944 2.55279C11.725 2.214 11.3788 2 11 2H9ZM7 8C7 7.44772 7.44772 7 8 7C8.55228 7 9 7.44772 9 8V14C9 14.5523 8.55228 15 8 15C7.44772 15 7 14.5523 7 14V8ZM12 7C11.4477 7 11 7.44772 11 8V14C11 14.5523 11.4477 15 12 15C12.5523 15 13 14.5523 13 14V8C13 7.44772 12.5523 7 12 7Z'
      fill='#111827'
      className='fill-danger'
    ></path>
  </svg>,
];

const columns = [
  {
    title: "Titre",
    dataIndex: "titre",
    key: "titre",
    width: "32%",
  },
  {
    title: "Description",
    dataIndex: "description",
    key: "description",
  },

  {
    title: "Action",
    key: "status",
    dataIndex: "action",
  },
];

function Notification() {
  const [data, setData] = useState([]);
  const [titre,setTitre]=useState([]);
  const [description,setDescription]=useState([]);

  const [isModalOpen, setIsModalOpen] = useState(false);



  const handleOk = () => { 
   
    axios.post("/api/notification/add",{
    titre : titre , description : description
  }
  ).then(()=>{alert("add succes")  ;  getNotifications();setIsModalOpen(false);
}).catch((response)=>alert(response))

};
  useEffect(() => {
    getNotifications();
  }, []);
  const getNotifications = async () => {
    const response = await axios.get(
      "/api/notification/gets",
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("accessToken"),
        },
      }
    );
    if (response.status === 200) {
      setData(
        response.data.Notification.map((item) => ({
          key: item.id,
          titre: item.titre,
          description: item.description,
          action: (
            <>
              <Button
                type='link'
                danger
                onClick={() => deleteNotifications(item.id)}
              >
                {deletebtn}DELETE
              </Button>
              <ModalComponent titr={item.titre} desc={item.description}/>
            </>
          ),
        }))
      );
    }
  };

  async function deleteNotifications(id) {
    const response = await axios.delete(
      "/api/notification/delete",
      { data: { id: id } }
    );
    if (response.status === 200) {
      console.log("delteted");
      getNotifications();
    }
  }
  return (
    <>

<Modal
        title="Ajout du Notification"
        open={isModalOpen}
        onOk={handleOk}
        onCancel={() => setIsModalOpen(false)}
        footer={[
          <Button key='back' onClick={() => setIsModalOpen(false)}>
            Retour
          </Button>,
          <Button key='submit' type='primary' onClick={handleOk}>
            Ajouter
          </Button>,
        ]}
      >
      <Form>
       
                <Form.Item
                 
                  rules={[
                    { required: true, message: "Please input your title!" },
                  ]}
                >
                  <Input   placeholder="Titre de Notification" onChange={(e) => setTitre(e.target.value)}/>
                </Form.Item>
            
                <Form.Item
                  
                  rules={[
                    { required: true, message: "Please input your description!" },
                    { min : 6, message: "Please verify your description" },
                  ]}
                >
                  <Input  placeholder="Descprition de Notification" onChange={(e) => setDescription(e.target.value)} />
                </Form.Item>
              
                </Form>    

                
              
      </Modal>
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste de Notification'
              extra={
                <Button
                  type='primary'
                  onClick={()=>setIsModalOpen(true)}
                  icon={<PlusOutlined />}
                >
                  Nouvelle Notification
                </Button>
              }
            >
              <div className='table-responsive'>
                <Table
                  columns={columns}
                  dataSource={data}
                  pagination={false}
                  className='ant-border-space'
                />
              </div>
            </Card>
          </Col>
        </Row>
      </div>
    </>
  );
}

export default Notification;
