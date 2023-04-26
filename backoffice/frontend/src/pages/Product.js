import { useHistory as History } from "react-router-dom";
import { PlusOutlined } from "@ant-design/icons";
import {
  Button,
  Row,
  Tag,
  message,
  Col,
  Card,
  Table,
  Modal,
  Input,
  Upload,
  InputNumber,
  Typography,
} from "antd";
import React, { useEffect, useState } from "react";
import "../assets/styles/styles.css";
import axios from "axios";

const validatePrimeNumber = (number) => {
  if (number === 11) {
    return {
      validateStatus: 'success',
      errorMsg: null,
    };
  }
  return {
    validateStatus: 'error',
    errorMsg: 'The prime between 8 and 12 is 11!',
  };
};

const getBase64 = (file) =>
  new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });

const columns = [
  {
    title: "Image de Produit",
    dataIndex: "imageUrl",
    key: "imageUrl",
    width: "13%",
    render: (text) => (
      <img src={text[0]} className='treeviewImage' alt='Nothing to show here' />
    ),
  },

  {
    title: "Nom du produit",
    dataIndex: "name",
    key: "name",
    width: "17%",
  },

  {
    title: "Prix",
    key: "role",
    dataIndex: "price",
    width: "17%",
    render: (text) => text + " dt",
  },
  {
    title: "Remise",
    key: "discount",
    dataIndex: "discount",
    width: "17%",
    render: (text) => text + " %",
  },
  {
    title: "Prix Apres Remise",
    key: "priceAfterDiscount",
    dataIndex: "priceAfterDiscount",
    width: "17%",
    render: (text) => text + " dt",
  },
  {
    title: "Description",
    dataIndex: "description",
    key: "description",
    width: "17%",
  },

  {
    title: "Date de création",
    dataIndex: "createdAt",
    key: "createdAt",
    width: "15%",
  },

  {
    title: "Quantité",
    dataIndex: "quantity",
    key: "quantity",
    width: "13%",
    render: (text) => <Tag>{text}</Tag>,
  },

  {
    title: "Action",
    key: "action",
    dataIndex: "action",
  },
];

const { TextArea } = Input;
const { Text } = Typography;
const { Title } = Typography;

function Product() {
  const [data, setData] = useState([]);
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isModifyModalOpen, setIsModifyModalOpen] = useState(false);
  const [isCheckModalOpen, setIsCheckModalOpen] = useState(false);
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [discount, setDiscount] = useState(0);
  const [priceAfterDiscount, setpriceAfterDiscount] = useState(""); 
  const [description, setDescription] = useState("");
  const [dataModal, setDataModal] = useState({imageUrl:[]});
  const [quantity, setQuantity] = useState(1);
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewImage, setPreviewImage] = useState("");
  const [previewTitle, setPreviewTitle] = useState("");
  const [fileList, setFileList] = useState([]);
  const [urlList, setUrlList] = useState([]);
  const [newFileList, setNewFileList] = useState([]);

  const handlePreview = async (file) => {
    if (!file.url && !file.preview) {
      file.preview = await getBase64(file.originFileObj);
    }
    setPreviewImage(file.url || file.preview);
    setPreviewOpen(true);
    setPreviewTitle(
      file.name || file.url.substring(file.url.lastIndexOf("/") + 1)
    );
  };

  const handleChange = ({ fileList: newFileList }) => setFileList(newFileList);

  const [messageApi, contextHolder] = message.useMessage();

  const history = History();

  const success = () => {
    messageApi.open({
      type: "success",
      content: "Succés",
    });
  };

  const error = () => {
    messageApi.open({
      type: "error",
      content: "Erreur!",
    });
  };

  const uploadButton = (
    <div>
      <PlusOutlined />
      <div
        style={{
          marginTop: 8,
        }}
      >
        Upload
      </div>
    </div>
  );

  useEffect(() => {
    if (!localStorage.getItem("accessToken")) {
      history.push("/login");
    } else getProducts();
  }, []);

  const getProducts = async () => {
    const response = await axios.get("/api/products/", {
      headers: {
        Authorization: "Bearer " + localStorage.getItem("accessToken"),
      },
    });
    if (response.status === 200) {
      setData(
        response.data.data.map((item) => ({
          key: item._id,
          name: item.name,
          price: item.price,
          description: item.description,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
          discount : item.discount,
          priceAfterDiscount : item.priceAfterDiscount,
          createdAt: item.createdAt.split("T")[0],
          action: (
            <>
              <Button
                type='link'
                onClick={() => {
                  setIsModifyModalOpen(true);
                  setDataModal(item);
                  setName(item.name);
                  setDescription(item.description);
                  setPrice(item.price);
                  setQuantity(item.quantity);
                  setDiscount(item.discount);
                  setpriceAfterDiscount(item.priceAfterDiscount);
                  setFileList(item.imageUrl.map((thing) => ({ url: thing })));
                }}
                style={{ color: "#2798b7" }}
              >
                Modifier
              </Button>
              <Button
                type='link'
                onClick={() => deleteProduct(item._id)}
                style={{ color: "#1e758d" }}
              >
                Supprimer
              </Button>
            </>
          ),
        }))
      );
    }
  };

  const handleAddProduct = () => {
    const data = new FormData();
    fileList.forEach((file) => {
      data.append("file", file.originFileObj);
    });
    data.append("name", name);
    data.append("price", price);
    data.append("quantity", quantity);
    // description === undefined || description ===null ? data.append("description", "") : data.append("description", description);
    data.append("description", description);
    data.append("discount", discount);
    axios
      .post("/api/products/create", data)
      .then(() => {
        getProducts();
        success();
        setIsAddModalOpen(false);
      })
      .catch((err) => {
        console.log(err);
        error();
      });
  };

  const handleModifyProduct = (id) => {
    const data = new FormData();
    fileList.map((obj) => (obj.url !== undefined ? urlList.push(obj.url) : newFileList.push(obj.originFileObj)))
    if (urlList === []){
      fileList.forEach((file) => {
        data.append("file", file.originFileObj);
      });
      data.append("name", name);
      data.append("price", price);
      data.append("quantity", quantity);
      // description === undefined || description ===null ? data.append("description", "") : data.append("description", description);
      data.append("description", description);
      data.append("discount", discount);
    }
    else {
      fileList.forEach((file) => {
        data.append("file", file.originFileObj);
      });
      data.append("name", name);
      data.append("price", price);
      data.append("quantity", quantity);
      data.append("description", description);
      data.append("discount", discount);
      data.append("imageUrl", urlList);
    }
    axios
      .put(`/api/products/update/${id}`, data)
      .then(() => {
        getProducts();
        success();
        handleCancel();
      })
      .catch((err) => {
        console.log(err);
        error();
      });
  };

  const deleteProduct = (id) => {
    axios
      .delete(`/api/products/delete/${id}`)
      .then((response) => {
        if (response.status === 200) {
          getProducts();
          success();
        }
      })
      .catch((error) => {
        console.log(error);
        error();
      });
  };

  const handleCancel = () => {
    setIsAddModalOpen(false);
    setIsModifyModalOpen(false);
    setIsCheckModalOpen(false);
  };

  const handlePreviewCancel = () => {
    setPreviewOpen(false);
  };

  return (
    <>
      {contextHolder}
      <Modal
        title="Ajout d'un nouveau produit"
        open={isAddModalOpen}
        onCancel={() => setIsAddModalOpen(false)}
        footer={[
          <Button key='back' type='default' onClick={() => setIsAddModalOpen(false)}>
            Retour
          </Button>,
          <Button
            key='submit'
            type='primary'
            onClick={() => handleAddProduct()}
            style={{backgroundColor: "#1e758d", borderColor: "#1e758d"}}
          >
            Ajouter
          </Button>,
        ]}
      >
        <Upload
          beforeUpload={() => {
            return false;
          }}
          listType='picture-card'
          fileList={fileList}
          onPreview={handlePreview}
          onChange={handleChange}
        >
          {fileList.length >= 3 ? null : uploadButton}
        </Upload>
        <Modal
          open={previewOpen}
          title={previewTitle}
          footer={null}
          onCancel={handlePreviewCancel}
        >
          <img
            alt='example'
            style={{
              width: "100%",
            }}
            src={previewImage}
          />
        </Modal>
        <Input placeholder='Nom' onChange={(e) => setName(e.target.value)} />
        <Input placeholder='Prix' onChange={(e) => setPrice(e.target.value)} />
       
        <label>Remise (optionnel) : 
        <InputNumber
          
          min={0}
          max={100}
          defaultValue={0}
          onChange={(value) => setDiscount(value)}
        />
</label>
<br></br>
<label>Quantite : 
<InputNumber
          min={1}
          max={1000}
          defaultValue={1}
          onChange={(value) => setQuantity(value)}
        />
</label>

       
        <TextArea
          rows={4}
          placeholder='Description du produit'
          onChange={(e) => setDescription(e.target.value)}
        />
      </Modal>

      <Modal
        title='Modifier un Produit'
        open={isModifyModalOpen}
        onCancel={handleCancel}
        footer={[
          <Button key='back' onClick={() => setIsModifyModalOpen(false)}>
            Retour
          </Button>,
          <Button
            key='submit'
            type='primary'
            onClick={() => handleModifyProduct(dataModal._id)}
            style={{backgroundColor: "#1e758d", borderColor: "#1e758d"}}
          >
            Modifier
          </Button>,
        ]}
      >
        <Upload
          beforeUpload={() => {
            return false;
          }}
          listType='picture-card'
          fileList={fileList}
          onPreview={handlePreview}
          onChange={handleChange}
        >
          {fileList.length >= 3 ? null : uploadButton}
        </Upload>
        <Input
          placeholder={dataModal.name}
          onChange={(e) => setName(e.target.value)}
        />
        <Input
          placeholder={dataModal.price}
          onChange={(e) => setPrice(e.target.value)}
        />
        <label>Remise (optionnel) : 
        <InputNumber
          
          min={0}
          max={100}
          defaultValue={discount}
          onChange={(value) => setDiscount(value)}
        />
</label>
<br></br>
<label>Quantite : 
<InputNumber
          min={1}
          max={1000}
          defaultValue={quantity}
          onChange={(value) => setQuantity(value)}
        />
</label>
        <TextArea
          placeholder={dataModal.description}
          rows={4}
          onChange={(e) => setDescription(e.target.value)}
        />
      </Modal>

      <Modal
        title={<Title level={3} style={{color:"#155263",marginTop:10}}>Detailles du produit</Title>}
        open={isCheckModalOpen}
        onOk={handleCancel}
        onCancel={handleCancel}
        footer={[]}
      >
        <div>
          {dataModal.imageUrl.map((url) => (<Card
            hoverable
            style={{
              width: 120,
              height: 120,
              borderRadius: 10,
              display: "inline-block",
              margin: 12,
            }}
            cover={
              <img
                alt='example'
                src={url}
              />
            }/>
            )
          )
          }
        </div>
        <Text strong>Nom:  <Text style={{color:"#155263"}}>{dataModal.name}</Text></Text><br/>
        <Text strong>Prix:  <Text style={{color:"#155263"}}>{dataModal.price}</Text></Text><br/>
        <Text strong>Remise:  <Text style={{color:"#155263"}}>{dataModal.discount}</Text></Text><br/>
        <Text strong>Prix Apres Remise:  <Text style={{color:"#155263"}}>{dataModal.priceAfterDiscount}</Text></Text><br/>
        <Text strong>Quantité:  <Text style={{color:"#155263"}}>{dataModal.quantity}</Text></Text><br/>
        <Text strong>Description:  <Text style={{color:"#155263"}}>{dataModal.description}</Text></Text><br/>
        <Text strong>Date de création:  <Text style={{color:"#155263"}}>{dataModal.createdAt}</Text></Text>
      </Modal>

      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste des Produits'
              extra={
                <Button
                  type="primary"
                  onClick={() => setIsAddModalOpen(true)}
                  icon={<PlusOutlined />}
                  style={{backgroundColor: "#1e758d", borderColor: "#1e758d"}}
                >
                  Nouveau Produit
                </Button>
              }
            >
              <div className='table-responsive'>
                <Table
                  columns={columns}
                  dataSource={data}
                  pagination={false}
                  className='ant-border-space'
                  sorter={(a, b) => a.createdAt.localeCompare(b.createdAt)}
                  onRow={(record) => {
                    return {
                      onDoubleClick: () => {
                        setIsCheckModalOpen(true);
                        setDataModal(record);
                      },
                    };
                  }}
                />
              </div>
            </Card>
          </Col>
        </Row>
      </div>
    </>
  );
}

export default Product;
