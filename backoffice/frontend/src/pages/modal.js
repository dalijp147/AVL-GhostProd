import React, { useState } from "react";
import { Modal, Button} from "antd";
const ModalComponent = ({ titr,desc }) => {

const [isModalvisible, setIsModalvisible] = useState(false);
const showModal = () => {
setIsModalvisible(true);
};
const handle0k = () => {
    setIsModalvisible(false);
};
const handleCancel = () => {
    setIsModalvisible(false);
};
return (
<>
<Button type="primary" onClick={showModal}>
Details
</Button> 
<Modal
title="Details "
visible={isModalvisible}
onOk={handle0k}
onCancel={handleCancel}>
Titre  : {titr }
<br></br>
Description :
{
    desc
}
</Modal>
</>
)
}
export default ModalComponent;