import React, { useState } from 'react';
import {

    Form,
    Input,
    Button,
    Radio,
    Select,
    Cascader,
    InputNumber,
    Switch,
    Checkbox,
    Upload,
    DatePicker,
    Modal
  } from "antd";
  import { PlusOutlined, SettingOutlined } from '@ant-design/icons';
  import Datetime from 'react-datetime';

export default function ({open,onClose,onEventAdded}) {
//   const [isModalOpen, setIsModalOpen] = useState(false);
//   const showModal = () => {
//     setIsModalOpen(true);
//   };
//   const handleOk = () => {
//     setIsModalOpen(false);
//   };
//   const handleCancel = () => {
//     setIsModalOpen(false);
//   };

const [title,SetTitle]= useState("");
const [start,SetStart]= useState(new Date());
const [end,SetEnd]= useState(new Date());


const onSubmit = (event) => {
    event.preventDefault();
    onEventAdded({
        title,
        start,
        end
    })
    onClose();
}
  return (
    <>
      {/* <Button type="primary" onClick={showModal}>
        Open Modal
      </Button> */}
      <Modal title="Basic Modal" visible={open} onCancel={onClose} onOk={onSubmit}>
         <Form
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 14 }}
        layout="horizontal"

      >
         <Select
    showSearch
    placeholder="Select a person"
    optionFilterProp="children"
    onChange={SetTitle}
    filterOption={(input, option) =>
      (option?.label ?? '').toLowerCase().includes(input.toLowerCase())
    }
    options={[
      {
        value: 'nhg',
        label: 'nhg',
      },
      {
        value: 'kg',
        label: 'kg',
      },
      
    ]}
  />
           <DatePicker showTime onChange={SetStart} />
           <DatePicker showTime onChange={SetEnd} />

      </Form>
      </Modal>
    </>
  );
};