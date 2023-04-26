import { Menu } from "antd";
import { NavLink, useLocation } from "react-router-dom";
import logo from "../../assets/images/logo.png";
import jwt_decode from "jwt-decode";

function Sidenav({ color }) {
  const { pathname } = useLocation();
  const page = pathname.replace("/", "");

  const dashboard = [
    <svg
      width='20'
      height='20'
      viewBox='0 0 20 20'
      xmlns='http://www.w3.org/2000/svg'
      key={0}
    >
      <path
        d='M3 4C3 3.44772 3.44772 3 4 3H16C16.5523 3 17 3.44772 17 4V6C17 6.55228 16.5523 7 16 7H4C3.44772 7 3 6.55228 3 6V4Z'
        fill={color}
      ></path>
      <path
        d='M3 10C3 9.44771 3.44772 9 4 9H10C10.5523 9 11 9.44771 11 10V16C11 16.5523 10.5523 17 10 17H4C3.44772 17 3 16.5523 3 16V10Z'
        fill={color}
      ></path>
      <path
        d='M14 9C13.4477 9 13 9.44771 13 10V16C13 16.5523 13.4477 17 14 17H16C16.5523 17 17 16.5523 17 16V10C17 9.44771 16.5523 9 16 9H14Z'
        fill={color}
      ></path>
    </svg>,
  ];

  const feedback = [
    <svg
      width='20'
      height='20'
      viewBox='0 0 20 20'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
      key={0}
    >
      <path
        fillRule='evenodd'
        clipRule='evenodd'
        d='M3 6C3 4.34315 4.34315 3 6 3H16C16.3788 3 16.725 3.214 16.8944 3.55279C17.0638 3.89157 17.0273 4.29698 16.8 4.6L14.25 8L16.8 11.4C17.0273 11.703 17.0638 12.1084 16.8944 12.4472C16.725 12.786 16.3788 13 16 13H6C5.44772 13 5 13.4477 5 14V17C5 17.5523 4.55228 18 4 18C3.44772 18 3 17.5523 3 17V6Z'
        fill={color}
      ></path>
    </svg>,
  ];

  const product = [
    <svg
      width='20'
      height='20'
      viewBox='0 0 20 20'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
      key={0}
    >
      <path
        fillRule='evenodd'
        clipRule='evenodd'
        d='M3 6C3 4.34315 4.34315 3 6 3H16C16.3788 3 16.725 3.214 16.8944 3.55279C17.0638 3.89157 17.0273 4.29698 16.8 4.6L14.25 8L16.8 11.4C17.0273 11.703 17.0638 12.1084 16.8944 12.4472C16.725 12.786 16.3788 13 16 13H6C5.44772 13 5 13.4477 5 14V17C5 17.5523 4.55228 18 4 18C3.44772 18 3 17.5523 3 17V6Z'
        fill={color}
      ></path>
    </svg>,
  ];

  const pack = [
    <svg
      width='20'
      height='20'
      viewBox='0 0 20 20'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
      key={0}
    >
      <path
        fillRule='evenodd'
        clipRule='evenodd'
        d='M3 6C3 4.34315 4.34315 3 6 3H16C16.3788 3 16.725 3.214 16.8944 3.55279C17.0638 3.89157 17.0273 4.29698 16.8 4.6L14.25 8L16.8 11.4C17.0273 11.703 17.0638 12.1084 16.8944 12.4472C16.725 12.786 16.3788 13 16 13H6C5.44772 13 5 13.4477 5 14V17C5 17.5523 4.55228 18 4 18C3.44772 18 3 17.5523 3 17V6Z'
        fill={color}
      ></path>
    </svg>,
  ];

  const decoded = jwt_decode(localStorage.getItem("accessToken"));

  return (
    <>
      <div className='brand'>
        <img src={logo} alt='' />
        <span>Ghostprod Backoffice</span>
      </div>
      <hr />
      <Menu theme='light' mode='inline'>
        <Menu.Item key='1'>
          <NavLink to='/dashboard'>
            <span
              className='icon'
              style={{
                background: page === "dashboard" ? "#1e758d" : "",
              }}
            >
              {dashboard}
            </span>
            <span className='label'>Dashboard</span>
          </NavLink>
        </Menu.Item>
        {decoded.role === "super" && (
          <Menu.Item key='2'>
            <NavLink to='/admin'>
              <span
                className='icon'
                style={{
                  background: page === "admin" ? "#1e758d" : "",
                }}
              >
                {feedback}
              </span>
              <span className='label'>Admin</span>
            </NavLink>
          </Menu.Item>
        )}

        <Menu.Item key='10'>
          <NavLink to='/user'>
            <span
              className='icon'
              style={{
                background: page === "user" ? "#1e758d" : "",
              }}
            >
              {product}
            </span>
            <span className='label'>Users</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key='11'>
          <NavLink to='/feedback'>
            <span
              className='icon'
              style={{
                background: page === "feedback" ? "#1e758d" : "",
              }}
            >
              {product}
            </span>
            <span className='label'>Feedbacks</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key='12'>
          <NavLink to='/notification'>
            <span
              className='icon'
              style={{
                background: page === "Notification" ? color : "",
              }}
            >
              {dashboard}
            </span>
            <span className='label'>Notification</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key='4'>
          <NavLink to='/product'>
            <span
              className='icon'
              style={{
                background: page === "product" ? "#1e758d" : "",
              }}
            >
              {product}
            </span>
            <span className='label'>Products</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key='5'>
          <NavLink to='/pack'>
            <span
              className='icon'
              style={{
                background: page === "pack" ? "#1e758d" : "",
              }}
            >
              {pack}
            </span>
            <span className='label'>Packs</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key='13'>
          <NavLink to='/cart'>
            <span
              className='icon'
              style={{
                background: page === "cart" ? "#1e758d" : "",
              }}
            >
              {pack}
            </span>
            <span className='label'>Panier</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key="20">
          <NavLink to="/Map">
            <span
              className="icon"
              style={{
                background: page === "Map" ? "#1e758d" : "",
              }}
            >
              {dashboard}
            </span>
            <span className="label">Map</span>
          </NavLink>
        </Menu.Item>
        <Menu.Item key="19">
          <NavLink to="/Calendar">
            <span
              className="icon"
              style={{
                background: page === "Calendrier" ? "#1e758d" : "",
              }}
            >
              {dashboard}
            </span>
            <span className="label">Calendrier</span>
          </NavLink>
        </Menu.Item>
      </Menu>
    </>
  );
}

export default Sidenav;
