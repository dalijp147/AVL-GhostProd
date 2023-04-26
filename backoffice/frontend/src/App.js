import { Switch, Route, Redirect } from "react-router-dom";
import Home from "./pages/Home";
import Tables from "./pages/Tables";
import Product from "./pages/Product";
import Pack from "./pages/Pack";
import Profile from "./pages/Profile";
import SignUp from "./pages/SignUp";
import SignIn from "./pages/SignIn";
import Main from "./components/layout/Main";
import Feedback from "./pages/Feedback";
import User from "./pages/User";
import Admin from "./pages/Admin";
import Cart from './pages/Cart';
import Notification from "./pages/Notification";
import Calendar from "./pages/Calendar";
import MapComponent from "./pages/Map";
import "antd/dist/antd.min.css";
import "./assets/styles/main.css";
import "./assets/styles/responsive.css";

const accessToken=localStorage.getItem("accessToken");

function App() {
  return (
   
    <div className="App">
      <Switch>
        {!accessToken ?
        <><Route path="/sign-in" exact component={SignIn} /><Redirect from="*" to="/sign-in" replace/> </>
        :
        <>
        <Route path="/sign-up" exact component={SignUp} />
        <Main>
          <Route exact path="/dashboard" component={Home} />
          <Route exact path="/tables" component={Tables} />
          <Route exact path="/product" component={Product} />
          <Route exact path="/pack" component={Pack} />
          <Route exact path="/profile" component={Profile} />
          <Route exact path="/feedback" component={Feedback} />
          <Route exact path="/notification" component={Notification} />
          <Route exact path="/Calendar" component={Calendar} />
          <Route exact path="/user" component={User} />
          <Route exact path="/cart" component={Cart} />
          <Route exact path="/admin" component={Admin} />
          <Route exact path="/Map" component={MapComponent} />
          <Redirect from="*" to="/dashboard" />
        </Main>
        </>  }
      </Switch>
    </div>
  );
}

export default App;