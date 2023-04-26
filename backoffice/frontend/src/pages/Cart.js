import { Row, Col, Card, Table, Button, message, Tag, Select, Modal } from "antd";
import { useHistory as History } from "react-router-dom";
import React, { useEffect, useState } from "react";
import axios from "axios";

const columns = [
  {
    title: "Client",
    dataIndex: "client",
    key: "client",
    width: "17%",
  },
  {
    title: "Total du panier",
    dataIndex: "price",
    key: "price",
    width: "17%",
    render: (text) => text + " dt",
  },

  {
    title: "Date de création",
    key: "createdAt",
    dataIndex: "createdAt",
    width: "17%",
  },

  {
    title: "Livreur",
    key: "livreur",
    dataIndex: "livreur",
    width: "17%",
  },

  {
    title: "Etat de livraison",
    key: "state",
    dataIndex: "state",
    width: "17%",
  },
  
  {
    title: "Liste des produits",
    key: "productList",
    dataIndex: "productList",
  },
];

function Pack() {

  const [data, setData] = useState([]);
  const [livreurs, setLivreurs] = useState([]);
  const [selectedValue,setSelectedValue] = useState({
    key: "",
    value: ""
  });

  var selectedName = '';

  const [messageApi, contextHolder] = message.useMessage();
  const [isModalConfirmOpen, setIsModalConfirmOpen] = useState({bool:false,value:{}});

  const showConfirmModal = (item) => {
    console.log(item)
    setIsModalConfirmOpen({bool:true,value:item});
  }; 
  const handleConfirmOk = () => {
    setIsModalConfirmOpen({bool:false,value:""});
    if(isModalConfirmOpen.value._id===selectedValue.key ){
                    
      changeState(isModalConfirmOpen.value)
      console.log(selectedValue.value)
    }
    else {
      
      error()
      
      console.log(selectedValue.key)
    }
  

    
  };

  const handleConfirmCancel = () => {
    setIsModalConfirmOpen({bool:false,value:""});
  };
  
  const success = () => {
    messageApi.open({
      type: "success",
      content: "Succès",
    });
  };
  
  const error = () => {
    messageApi.open({
      type: "error",
      content: "Erreur!",
    });
  };
  useEffect(() => {
    // getPacks()
    getLivreurs();
  }, []);

  useEffect(() => {
    getPacks()
    
  }, [livreurs,selectedValue]);

  

  const getLivreurs = async () => {
    await axios
    .get('/api/auth/getlivreurs')
    .then((res) => {
      setLivreurs(res.data);
      console.log(livreurs)
      // getPacks(res.data);
    })
  }

  const getPacks = async () => {
    const response = await axios.get("/api/panier/gets", {
      headers: {
        Authorization: "Bearer " + localStorage.getItem("accessToken"),
      },
    });
    console.log(response.data)
    if (response.status === 200) {
      setData(
        response.data.map((item) => (
          {
          key: item._id._id,
          client: item._id.client.map((thing) => thing.username),
          price: item._id.total,
          createdAt: item._id.createdAt.split("T")[0],
          livreur: (
            <>
              <Select
                defaultValue={item._id.livreur === null ? 'Livreur' : item._id.livreur}
                disabled={item._id.state === 0 ? false : true}
                style={{
                  width: 120,
                }}
                onChange={(value) => {
                  // selectedName = value;
                  setSelectedValue({
                    key: item._id._id,
                    value: value
                  });
                  // console.log(selectedValue);
                }}
                options={livreurs}
              />
            </>
          ),
          state: (
            <>
              <Button
                type='link'
                
                onClick={() => {
                  item._id.livreur !== null && (setSelectedValue({key:item._id._id,value:item._id.livreur})) 
                  showConfirmModal(item._id)
                  
                  
                  
                }}
                style={{
                  color: item._id.state === 0 ? "#ff7700" : "#90EE90",
                  borderColor: item._id.state === 0 ? "#ff7700" : "#90EE90",
                }}
              >
                {item._id.state === 0 ? "En cours" : "Confirmé"}
              </Button>
            </>
          ),
          productList: item.produits.map((thing) => (
            <Tag>{thing.product.name}</Tag>
          )),
        }))
      );
    }
  };


  const changeState = (id) => {
    console.log(selectedValue);
    axios
      .put("/api/panier/state", { id: id, livreur: selectedValue.value })
      .then((res) => {
        if (res.status === 200) {
          success();
          getLivreurs();
          
        }
        else if (res.status === 201 ){
          error();
          
          getLivreurs();
        }
      })
      .catch((error) => {
        error();
        
        console.log(error);
      })
      setSelectedValue({key:"",value:""});
    }
   
  return (
    <>
     <Modal title="Basic Modal" open={isModalConfirmOpen.bool} onOk={handleConfirmOk} onCancel={handleConfirmCancel}>
         
         </Modal>
      {contextHolder}
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste des paniers'
            >
              <div className='table-responsive'>
                <Table
                  columns={columns}
                  dataSource={data}
                  pagination={false}
                  className='ant-border-space'
                  sorter= {(a, b) => new Date(a.createdAt) - new Date(b.createdAt)}
                />
              </div>
            </Card>
          </Col>
        </Row>
      </div>
    </>
  );
}

export default Pack;
