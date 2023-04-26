import {
  Row,
  Tag,
  Col,
  Card,
  Table,
  Button,
  message,
  Modal,
  Input,
  Select,
  Form,
  Space,
  InputNumber,
  Typography,
} from "antd";
import { PlusOutlined, MinusCircleOutlined } from "@ant-design/icons";
import { useHistory as History } from "react-router-dom";
import React, { useEffect, useState } from "react";
import axios from "axios";

const columns = [
  {
    title: "Nom du pack",
    dataIndex: "title",
    key: "title",
    width: "15%",
  },
  {
    title: "Prix",
    dataIndex: "price",
    key: "price",
    width: "15%",
    render: (text) => text + " dt",
  },

  {
    title: "Description",
    key: "description",
    dataIndex: "description",
    width: "20%",
  },

  {
    title: "Date de création",
    key: "createdAt",
    dataIndex: "createdAt",
    width: "15%",
  },

  {
    title: "Liste des produits",
    key: "productList",
    dataIndex: "productList",
  },

  {
    title: "Action",
    key: "status",
    dataIndex: "action",
  },
];

const { TextArea } = Input;
const { Text, Title } = Typography;

function Pack() {
  const [data, setData] = useState([]);
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isModifyModalOpen, setIsModifyModalOpen] = useState(false);
  const [isCheckModalOpen, setIsCheckModalOpen] = useState(false);
  const [dataModal, setDataModal] = useState({ productList: [] });
  const [onRowClick, setOnRowClick] = useState({ productList: [] });
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [products, setProducts] = useState([]);
  const [selectedValues, setSelectedValues] = useState([]);
  
  const history = History();
  
  const [form] = Form.useForm();

  const [messageApi, contextHolder] = message.useMessage();

  const success = () => {
    messageApi.open({
      type: "success",
      content: "Succés!",
    });
  };

  const error = () => {
    messageApi.open({
      type: "error",
      content: "Erreur!",
    });
  };

  useEffect(() => {
    if (!localStorage.getItem("accessToken")) {
      history.push("/login");
    } else {
      getPacks();
      getProducts();
    }
  }, []);

  const getPacks = async () => {
    const response = await axios.get("/api/packs", {
      headers: {
        Authorization: "Bearer " + localStorage.getItem("accessToken"),
      },
    });
    if (response.status === 200) {
      setData(
        response.data.data.map((item) => ({
          key: item._id._id,
          title: item._id.title,
          price: item._id.price,
          description: item._id.description,
          createdAt: item._id.createdAt.split("T")[0],
          productList: item.produits.map((product) => (
            <Tag>
              {product.quantity} x {product.product.name}
            </Tag>
          )),
          action: (
            <>
              <Button
                type='link'
                onClick={() => {
                  setIsModifyModalOpen(true);
                  setDataModal(item);
                  setName(item._id.title);
                  setDescription(item._id.description);
                  setPrice(item._id.price);
                  setSelectedValues(item.produits.map(prod => ({_id: prod._id, quantity: prod.quantity})));
                }}
                style={{ color: "#ff7700" }}
              >
                Modifier
              </Button>
              <Button type='link' danger onClick={() => deletePack(item._id._id)}>
                Supprimer
              </Button>
            </>
          ),
        }))
      );
    }
  };

  const deletePack = (id) => {
    axios
      .delete(`/api/packs/deletepack/${id}`)
      .then((response) => {
        if (response.status === 200) {
          success();
          getPacks();
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleCancel = () => {
    setIsAddModalOpen(false);
    setIsModifyModalOpen(false);
    setIsCheckModalOpen(false);
  };

  const getProducts = async () => {
    const response = await axios.get("/api/products/", {
      headers: {
        Authorization: "Bearer " + localStorage.getItem("accessToken"),
      },
    });
    if (response.status === 200) {
      setProducts(
        response.data.data.map((item) => ({
          key: item._id,
          label: item.name,
          value: item._id,
        }))
      );
    }
  };

  const onAddFinish = (values) => {
    values.productList.map(prod => ((prod.quantity === undefined || prod.quantity === null) && (prod.quantity = 1)))
    axios
      .post("/api/packs/createpack", values)
      .then(() => {
        getPacks();
        success();
        setIsAddModalOpen(false);
      })
      .catch((err) => {
        console.log(err);
        error();
      });
  };

  const onModifyFinish = (values) => {
    values.productList.map(prod => ((prod.quantity === undefined || prod.quantity === null) && (prod.quantity = 1)))
    axios
      .put(`/api/packs/update/${dataModal._id._id}`, values)
      .then(() => {
        getPacks();
        success();
        setIsModifyModalOpen(false);
      })
      .catch((error) => {
        error();
      });
  }

  return (
    <>
      {contextHolder}
      <Modal
        title="Ajout d'un nouveau pack"
        open={isAddModalOpen}
        onCancel={() => setIsAddModalOpen(false)}
        footer={[]}
      >
        <Form
          form={form}
          name='dynamic_form_complex'
          onFinish={onAddFinish}
          autoComplete='off'
        >
          <Form.Item
            name='title'
            label='Nom'
            rules={[
              {
                required: true,
                message: "Missing area",
              },
            ]}
          >
            <Input
              placeholder='Nom'
              onChange={(e) => setName(e.target.value)}
            />
          </Form.Item>
          <Form.Item
            name='price'
            label='Prix'
            rules={[
              {
                required: true,
                message: "Ajouter un prix",
              },
            ]}
          >
            <Input
              placeholder='Prix'
              onChange={(e) => setPrice(e.target.value)}
            />
          </Form.Item>
          <Form.Item name='description' label='Description'>
            <TextArea
              rows={4}
              onChange={(e) => setDescription(e.target.value)}
            />
          </Form.Item>
          <Form.List name='productList'>
            {(fields, { add, remove }) => (
              <>
                {fields.map((field) => (
                  <Space key={field.key} align='baseline'>
                    <Form.Item
                      noStyle
                      shouldUpdate={(prevValues, curValues) =>
                        prevValues.produits !== curValues.produits
                      }
                    >
                      {() => (
                        <Form.Item
                          {...field}
                          label='Produit'
                          name={[field.name, "_id"]}
                          rules={[
                            {
                              required: true,
                              message: "Missing product",
                            },
                          ]}
                        >
                          <Select
                            style={{
                              width: 130,
                            }}
                            options={products}
                          />
                        </Form.Item>
                      )}
                    </Form.Item>
                    <Form.Item
                      {...field}
                      label='Quantité'
                      name={[field.name, "quantity"]}
                    >
                      <InputNumber min={1} max={100} defaultValue={1} />
                    </Form.Item>

                    <MinusCircleOutlined onClick={() => remove(field.name)} />
                  </Space>
                ))}

                <Form.Item>
                  <Button
                    type='dashed'
                    onClick={() => add()}
                    block
                    icon={<PlusOutlined />}
                  >
                    Ajouter un produit
                  </Button>
                </Form.Item>
              </>
            )}
          </Form.List>
          <Form.Item>
            <Button type='primary' htmlType='submit' style={{ marginLeft: "43%" ,marginTop: "5%"}}>
              Ajouter
            </Button>
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title='Modifier un Produit'
        open={isModifyModalOpen}
        onCancel={handleCancel}
        footer={[]}
      >
        <Form
          form={form}
          name='dynamic_form_complex'
          onFinish={onModifyFinish}
          autoComplete='off'
        >
          <Form.Item
            name='title'
            label='Nom'
            rules={[
              {
                required: true,
                message: "Missing area",
              },
            ]}
            initialValue={name}
          >
            <Input
              placeholder={name}
            />
          </Form.Item>
          <Form.Item
            name='price'
            label='Prix'
            rules={[
              {
                required: true,
                message: "Ajouter un prix",
              },
            ]}
            initialValue={price}
          >
            <Input
              placeholder={price}
            />
          </Form.Item>
          <Form.Item name='description' label='Description' initialValue={description}>
            <TextArea
              rows={4}
              placeholder={description}
            />
          </Form.Item>
          <Form.List name='productList' initialValue={selectedValues}>
            {(newFields, { add, remove }) => ( 
              <>
                {newFields.map((field) => (
                  <Space key={field.key} align='baseline'>
                    <Form.Item
                      noStyle
                      shouldUpdate={(prevValues, curValues) =>
                        prevValues.produits !== curValues.produits
                      }
                    >
                      {() => (
                        <Form.Item
                          {...field}
                          label='Produit'
                          name={[field.name, "_id"]}
                          rules={[
                            {
                              required: true,
                              message: "Missing product",
                            },
                          ]}
                        >
                          <Select
                            style={{
                              width: 130,
                            }}
                            options={products}
                          />
                        </Form.Item>
                      )}
                    </Form.Item>
                    <Form.Item
                      {...field}
                      label='Quantité'
                      name={[field.name, "quantity"]}
                    >
                      <InputNumber  placeholder="1" />
                    </Form.Item>

                    <MinusCircleOutlined onClick={() => remove(field.name)} />
                  </Space>
                ))}

                <Form.Item>
                  <Button
                    type='dashed'
                    onClick={() => add()}
                    block
                    icon={<PlusOutlined />}
                  >
                    Ajouter un produit
                  </Button>
                </Form.Item>
              </>
            )}
          </Form.List>
          <Form.Item>
            <Button type='primary' htmlType='submit' style={{ marginLeft: "43%" ,marginTop: "5%"}}>
              Modifier
            </Button>
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title={<Title level={3} style={{color:"#155263",marginTop:10}}>Detailles du pack</Title>}
        open={isCheckModalOpen}
        onOk={handleCancel}
        onCancel={handleCancel}
        footer={[]}
      >
        <Text strong>Nom:  <Text style={{color:"#155263"}}>{onRowClick.title}</Text></Text><br/>
        <Text strong>Prix:  <Text style={{color:"#155263"}}>{onRowClick.price}</Text></Text><br/>
        <Text strong>Description:  <Text style={{color:"#155263"}}>{onRowClick.description}</Text></Text><br/>
        <Text strong>Liste des produits: {onRowClick.productList.map((prod) => prod)}</Text><br/>
        <Text strong>Date de création:  <Text style={{color:"#155263"}}>{onRowClick.createdAt}</Text></Text>
      </Modal>
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste des packs'
              extra={
                <Button
                  type='primary'
                  onClick={() => {
                    setIsAddModalOpen(true);
                  }}
                  icon={<PlusOutlined />}
                >
                  Nouveau Pack
                </Button>
              }
            >
              <div className='table-responsive'>
                <Table
                  columns={columns}
                  dataSource={data}
                  pagination={false}
                  className='ant-border-space'
                  onRow={(record) => {
                    return {
                      onDoubleClick: () => {
                        setIsCheckModalOpen(true);
                        setOnRowClick(record);
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

export default Pack;

