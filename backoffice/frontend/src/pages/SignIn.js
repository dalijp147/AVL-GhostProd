import React, { Component } from "react";
import { Layout, Button, Row, Col, Typography, Form, Input } from "antd";
import axios from "axios";
import signinbg from "../assets/images/img-signin.jpg";
import { HeartFilled } from "@ant-design/icons";

const { Title } = Typography;
const { Footer, Content } = Layout;

export default class SignIn extends Component {
  render() {
    const onFinish = (values) => {
      axios
        .post("/api/login", {
          username: values.username,
          password: values.password,
        })
        .then((response) => {
          localStorage.setItem("accessToken", response.data.token);
        })
        .then(() => {
          this.props.history.push("/dashboard");
          window.location.reload();
        })
        .catch((error) => console.log(error));
    };

    const onFinishFailed = (errorInfo) => {
      console.log("Failed:", errorInfo);
    };
    return (
      <>
        <Layout className='layout-default layout-signin'>
          <Content className='signin'>
            <Row gutter={[24, 0]} justify='space-around'>
              <Col
                xs={{ span: 24, offset: 0 }}
                lg={{ span: 6, offset: 2 }}
                md={{ span: 12 }}
              >
                <Title className='mb-15'>S'identifier</Title>
                <Title className='font-regular text-muted' level={5}>
                  Entrez votre nom d'utilisateur et votre mot de passe pour vous
                  connecter{" "}
                </Title>
                <Form
                  onFinish={onFinish}
                  onFinishFailed={onFinishFailed}
                  layout='vertical'
                  className='row-col'
                >
                  <Form.Item
                    className='username'
                    label="Nom d'Utilisateur"
                    name='username'
                    onChange={this.setState.username}
                    rules={[
                      {
                        required: true,
                        message: "Veuillez saisir votre nom d'utilisateur !",
                      },
                    ]}
                  >
                    <Input placeholder='username' />
                  </Form.Item>

                  <Form.Item
                    className='username'
                    label='Mot De Passe'
                    name='password'
                    onChange={this.setState.password}
                    rules={[
                      {
                        required: true,
                        message: "Veuillez saisir votre mot de passe !",
                      },
                    ]}
                  >
                    <Input placeholder='Password' type='password' />
                  </Form.Item>

                  <Form.Item
                    name='remember'
                    className='aligin-center'
                    valuePropName='checked'
                  ></Form.Item>

                  <Form.Item>
                    <Button
                      type='primary'
                      htmlType='submit'
                      style={{ width: "100%" }}
                    >
                      S'identifier
                    </Button>
                  </Form.Item>
                </Form>
              </Col>
              <Col
                className='sign-img'
                style={{ padding: 12 }}
                xs={{ span: 24 }}
                lg={{ span: 12 }}
                md={{ span: 12 }}
              >
                <img src={signinbg} alt='' />
              </Col>
            </Row>
          </Content>
          <Footer>
            <div className='copyright'>
              © 2022, made with
              {<HeartFilled />} by
              <a
                href='https://inceptumje.tn'
                rel='noreferrer'
                className='font-weight-bold'
                target='_blank'
              >
                Inceptum Junior Entreprise{" "}
              </a>
              for a better web.
            </div>
          </Footer>
        </Layout>
      </>
    );
  }
}
