import {
  Row,
  Col,
  Card,
  Table,
  Tag,
  Button,
  Radio,
  Input,
  Form,
  Modal,
} from "antd";
import React, { useEffect, useState } from "react";
import axios from "axios";
import { PlusOutlined } from "@ant-design/icons";

const columns = [
  {
    title: "Username",
    dataIndex: "username",
    key: "username",
    width: "22%",
  },
  {
    title: "E-mail",
    dataIndex: "email",
    key: "description",
    width: "22%",
  },

  {
    title: "Role",
    key: "role",
    dataIndex: "role",
    width: "22%",
    render: (text) => (
      <Tag color={text === "client" ? "green" : "orange"}>{text}</Tag>
    ),
  },

  {
    title: "Vérification",
    key: "verified",
    dataIndex: "verified",
    width: "22%",
  },

  {
    title: "Action",
    key: "action",
    dataIndex: "action",
    width: "22%",
  },
];

function User() {
  const [username, setUsername] = useState([]);
  const [password, setPassword] = useState([]);
  const [email, setEmail] = useState([]);
  const [valuerg, setValuerg] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [data, setData] = useState([]);

  useEffect(() => {
    getUsers("client");
  }, []);

  const getUsers = async (role) => {
    const response = await axios.get(
      "/api/auth/getUsers",
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("accessToken"),
        },
      }
    );
    if (response.status === 200) {
      setData(
        response.data
          .filter((useer) => useer.role === role)
          .map((item) => ({
            key: item._id,
            username: item.username,
            email: item.email,
            role: item.role,
            verified: (
              <>
                <Button
                  danger
                  type='link'
                  disabled={item.verified === true ? true : false}
                  onClick={() => changeVerified(item._id,item.role)}
                  style={{
                    color: item.verified === false ? "#f72800" : "#80c186",
                  }}
                >
                  {item.verified === false ? "non vérifié" : "Vérifié"}
                </Button>
              </>
            ),
            action: (
              <>
                {item.etat === 0 && (
                  <Button danger onClick={() => blockuser(item._id, item.role)}>
                    BLOCK
                  </Button>
                )}
                {item.etat === 1 && (
                  <Button
                    danger
                    onClick={() => unblockuser(item._id, item.role)}
                  >
                    UNBLOCK
                  </Button>
                )}
              </>
            ),
          }))
      );
    }
  };

  const onChange = (e) => {
    getUsers(e.target.value);
    setValuerg(e.target.value);
  };

  const changeVerified = async (id,role) => {
    await axios
      .put("/api/auth/verified", {
        id: id,
      })
      .then((res) => {
        getUsers(role);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  async function blockuser(id2, role) {
    const response = await axios.put(
      "/api/auth/block",
      {
        id: id2,
      },
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("accessToken"),
        },
      }
    );
    if (response.status === 200) {
      getUsers(role);
    }
  }
  async function unblockuser(id2, role) {
    const response = await axios.put(
      "/api/auth/unblock",
      {
        id: id2,
      },
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("accessToken"),
        },
      }
    );
    if (response.status === 200) {
      console.log("bocked", id2);
      getUsers(role);
    }
  }

  const handleOk = () => {
    const pattern =
      /[a-zA-Z0-9]+[\.]?([a-zA-Z0-9]+)?[\@][a-z]{3,9}[\.][a-z]{2,5}/g;
    const result = pattern.test(email);
    if (result) {
      if (password !== username) {
        if (password.length > 6)
          axios
            .post(
              "/api/auth/registerlivreuradmin",
              {
                username: username,
                password: password,
                email: email,
                role: "livreur",
              },
              {
                headers: {
                  Authorization:
                    "Bearer " + localStorage.getItem("accessToken"),
                },
              }
            )
            .then(() => {
              alert("add succes");
              getUsers("livreur");
              setIsModalOpen(false);
            })
            .catch((response) => alert(response));
        else {
          alert("le password doit contenir au moins 6 caracteres");
        }
      } else {
        alert("le password doit etre different de username");
      }
    } else {
      alert("verif email");
    }
  };

  return (
    <>
      <Modal
        title="Ajout d'un nouveau livreur"
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
            rules={[{ required: true, message: "Please input your username!" }]}
          >
            <Input
              placeholder='UserName'
              onChange={(e) => setUsername(e.target.value)}
            />
          </Form.Item>
          <Form.Item
            rules={[
              { required: true, message: "Please input your email!" },

              { type: "email", message: "The input is not valid E-mail!" },
            ]}
          >
            <Input
              placeholder='email'
              onChange={(e) => setEmail(e.target.value)}
            />
          </Form.Item>
          <Form.Item
            rules={[
              { required: true, message: "Please input your password!" },
              { min: 6, message: "Please verify your password" },
            ]}
          >
            <Input
              placeholder='Passwoed'
              onChange={(e) => setPassword(e.target.value)}
            />
          </Form.Item>
        </Form>
      </Modal>
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Liste des Utilisateurs'
              extra={
                <>
                  <Radio.Group onChange={onChange} defaultValue='client'>
                    <Radio.Button value='client'>Client</Radio.Button>
                    <Radio.Button value='livreur'>Livreur</Radio.Button>
                    {valuerg === "livreur" && (
                      <Button
                        type='primary'
                        onClick={() => setIsModalOpen(true)}
                        icon={<PlusOutlined />}
                      >
                        Nouveau Livreur
                      </Button>
                    )}
                  </Radio.Group>
                </>
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

export default User;
