import {
    Row,
    Col,
    Card,
    Table,
    Typography,Button,Form,Tag,
    Input,Modal
  } from "antd";
  import{useHistory as History} from 'react-router-dom'

  import { ToTopOutlined,PlusOutlined } from "@ant-design/icons";
  import { Link } from "react-router-dom";
  import React ,{useEffect,useState}from "react";
  import axios from "axios"
import Icon from "@ant-design/icons/lib/components/Icon";
import ListBody from "antd/lib/transfer/ListBody";
  // Images
  import jwt_decode from "jwt-decode";

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
    title: "Username",
    dataIndex: "username",
    key: "username",
    width: "32%",
  },
  {
    title: "E-mail",
    dataIndex: "email",
    key: "description",
  },

  {
    title: "Role",
    key: "role",
    dataIndex: "role",
    render: (text) => <Tag color='red'>{text}</Tag>
  },
  {
    title: "Action",
    key: "action",
    dataIndex: "action",
  },
];

  function Admin() {
   const [data,setData]=useState([]);
   const [username,setUsername]=useState([]);
   const [password,setPassword]=useState([]);
   const [email,setEmail]=useState([]);

   const [isModalOpen, setIsModalOpen] = useState(false);

   const decoded = jwt_decode(localStorage.getItem("accessToken"));
   let history=History();
  useEffect(()=>{
    if(!localStorage.getItem("accessToken"))
    {
      history.push("/login");
    }else if (decoded.role==="super")
    getUsers();
  },[])
  const getUsers =async ()=>
  {
    const response = await axios.get("/api/auth/getadmins",{
      headers: {
        "Authorization": "Bearer " + localStorage.getItem("accessToken")
      }
    });
  
    if(response.status===200)
    {
        setData(response.data.user.map(
            item=>({
            key:item.id,
            username:item.username,
            email:item.email,
            role:item.role,
            action:(<>
              <Button type="link" danger onClick={()=>deleteadmin(item.id)}>
                          {deletebtn}DELETE
                        </Button></>)
        })));
       
    }else
    {
      console.log(response.status);
    }
  };
  const handleOk = () => { 
    const pattern = /[a-zA-Z0-9]+[\.]?([a-zA-Z0-9]+)?[\@][a-z]{3,9}[\.][a-z]{2,5}/g;
    const result = pattern.test(email);
    if(result){
    if(password.length>6)
    axios.post("/api/auth/registerlivreuradmin",{
    username : username , password : password,email : email,role : "admin"
  },{
    headers: {
      "Authorization": "Bearer " + localStorage.getItem("accessToken")
    }
  
    
  }).then(()=>{alert("add succes")  ;  getUsers();setIsModalOpen(false);
}).catch((response)=>alert(response))
else
{
  alert("le password doit contenir au moins 6 caracteres");
}}
else
{
  alert("verif email");
}
};
  async function deleteadmin(id)  {
    const response = await axios.delete("/api/auth/delete",{
      headers: {
        "Authorization": "Bearer " + localStorage.getItem("accessToken")
      },
      data:
        {id : id}
      ,
    });
    if(response.status===200)
    {
        console.log("delteted");
         getUsers();
    }
  };
 

    return (
      <>
     <Modal
        title="Ajout d'un nouveau Administrateur"
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
                    { required: true, message: "Please input your username!" },
                  ]}
                >
                  <Input   placeholder="UserName" onChange={(e) => setUsername(e.target.value)}/>
                </Form.Item>
                <Form.Item
                 
                  rules={[
                    { required: true, message: "Please input your email!" },
                  
                    {type: "email",
                    message: "The input is not valid E-mail!",
                    }
                  ]}
                >
                  <Input placeholder="email" onChange={(e) => setEmail(e.target.value)}/>
                </Form.Item>
                <Form.Item
                  
                  rules={[
                    { required: true, message: "Please input your password!" },
                    { min : 6, message: "Please verify your password" },
                  ]}
                >
                  <Input type="password" placeholder="Passwoed" onChange={(e) => setPassword(e.target.value)} />
                </Form.Item>
              
                </Form>    

                
              
      </Modal>
        <div className="tabled">
        
          <Row gutter={[24, 0]}>
            <Col xs="24" xl={24}>
          
              <Card
                bordered={false}
                className="criclebox tablespace mb-24"
                title="Liste des Administrateurs"
                extra={
                  <Button
                    type='primary'
                    onClick={()=>setIsModalOpen(true)}
                    icon={<PlusOutlined />}
                  >
                    Nouveau Admin
                  </Button>
                }
              >
                
                <div className="table-responsive">
 
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

export default Admin;
