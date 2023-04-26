import { Row, Col, Card, Select } from "antd";
import CalendarComponent from "../components/Calendar/CalendarComponent";
import { useEffect, useState } from "react";

// const { RangePicker } = DatePicker;
// const { TextArea } = Input;
function Calendar() {
  const [titleProduct, setProductTitle] = useState("");
  useEffect(() => {
    Calendar();
  }, [titleProduct]);
  const Calendar = () => {
    return <CalendarComponent titleProduct={titleProduct} />;
  };

  return (
    <>
      <div className='tabled'>
        <Row gutter={[24, 0]}>
          <Col xs='24' xl={24}>
            <Card
              bordered={false}
              className='criclebox tablespace mb-24'
              title='Authors Table'
              extra={
                <>
                  <Select
                    showSearch
                    placeholder='Select a person'
                    optionFilterProp='children'
                    onChange={setProductTitle}
                    filterOption={(input, option) =>
                      (option?.label ?? "")
                        .toLowerCase()
                        .includes(input.toLowerCase())
                    }
                    options={[
                      {
                        value: "nhg",
                        label: "nhg",
                      },
                      {
                        value: "kg",
                        label: "kg",
                      },
                    ]}
                  />
                </>
              }
            >
              <div className='table-responsive'>
                <Calendar />
                {/* <Form
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 14 }}
        layout="horizontal"
      >
        <Form.Item label="Checkbox" name="disabled" valuePropName="checked">
          <Checkbox>Checkbox</Checkbox>
        </Form.Item>
        <Form.Item label="Radio">
          <Radio.Group>
            <Radio value="apple"> Apple </Radio>
            <Radio value="pear"> Pear </Radio>
          </Radio.Group>
        </Form.Item>
        <Form.Item label="Input">
          <Input />
        </Form.Item>
        <Form.Item label="Select">
          <Select>
            <Select.Option value="demo">Demo</Select.Option>
          </Select>
        </Form.Item>
        
        <Form.Item label="Cascader">
          <Cascader
            options={[
              {
                value: 'zhejiang',
                label: 'Zhejiang',
                children: [
                  {
                    value: 'hangzhou',
                    label: 'Hangzhou',
                  },
                ],
              },
            ]}
          />
        </Form.Item>
        
        <Form.Item label="RangePicker">
          <RangePicker />
        </Form.Item>
        <Form.Item label="InputNumber">
          <InputNumber />
        </Form.Item>
        <Form.Item label="TextArea">
          <TextArea rows={4} />
        </Form.Item>
        <Form.Item label="Switch" valuePropName="checked">
          <Switch />
        </Form.Item>
        <Form.Item label="Upload" valuePropName="fileList">
          <Upload action="/upload.do" listType="picture-card">
            <div>
              <PlusOutlined />
              <div style={{ marginTop: 8 }}>Upload</div>
            </div>
          </Upload>
        </Form.Item>
        <Form.Item label="Button">
          <Button>Button</Button>
        </Form.Item>
      </Form> */}
              </div>
            </Card>
          </Col>
        </Row>
      </div>
    </>
  );
}

export default Calendar;
