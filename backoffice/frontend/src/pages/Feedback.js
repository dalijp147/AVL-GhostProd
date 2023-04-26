import { Row, Col, Card, Table, Button } from "antd";
import React, { useEffect, useState } from "react";
import axios from "axios";
import ModalComponent from "./modal";
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

function Feedback() {
  const [data, setData] = useState([]);

  useEffect(() => {
    getFeedbacks();
  }, []);
  const getFeedbacks = async () => {
    const response = await axios.get(
      "/api/feedback/gets",
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("accessToken"),
        },
      }
    );
    if (response.status === 200) {
      setData(
        response.data.feedback.map((item) => ({
          key: item.id,
          titre: item.titre,
          description: item.description,
          action: (
            <>
              <Button
                type='link'
                danger
                onClick={() => deleteFeedbacks(item.id)}
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

  async function deleteFeedbacks(id) {
    const response = await axios.delete(
      "/api/feedback/delete",
      { data: { id: id } }
    );
    if (response.status === 200) {
      console.log("delteted");
      getFeedbacks();
    }
  }
  return (
    <>
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste de Feedback'
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

export default Feedback;
