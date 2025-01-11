const CompanyrootRoute = "/company";
const VendorrootRoute= "/vendor";


const prelogin = "/prelogin";

const homePageDisplayName = "Home";
const homePageRoute = "/home";



const dashBoardPageDisplayName = "Dashboard";
const dashBoardPageRoute = "/dashboard";

const mapPageDisplayName = "Map";
const mapPageRoute = "/map";

const driversPageDisplayName = "Drivers";
const driversPageRoute = "/drivers";

const vechilePageDisplayName = "Vehicle";
const vechilePageRoute = "/vehicle";

const employeesPageDisplayName = "Employees";
const employeesPageRoute = "/employees";

const vendorPageDisplayName = "Vendor";
const vendorPageRoute = "/vendor";

const reportPageDisplayName = "Report";
const reportPageRoute = "/report";

const tripPageDisplayName = "Trips";
const tripPageRoute = "/trips";

const teamPageDisplayName = "Teams";
const teamPageRoute = "/teams";

const helpdeskPageDisplayName = "Help Desk";
const helpdeskPageRoute = "/helpdesk";

const settingsPageDisplayName = "Settings";
const settingsPageRoute = "/settings";

const nodalPointPageDisplayName = "Nodal Point";
const nodalPointPageRoute = "/nodalpoint";

const roasterPageDisplayName = "Roaster";
const roasterPageRoute = "/roaster";


const companyVendorPageDisplayName = "Company";
const companyVendorPageRoute = "/company";

const vendorCompanyPageDisplayName = "Company";
const vendorCompanyPageRoute = "/vendorcompany";




const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}



List<MenuItem> companySideMenuItemRoutes = [
 MenuItem(homePageDisplayName, homePageRoute),
  MenuItem(mapPageDisplayName, mapPageRoute),
  MenuItem(roasterPageDisplayName,roasterPageRoute),
  MenuItem(employeesPageDisplayName, employeesPageRoute),
  MenuItem(nodalPointPageDisplayName, nodalPointPageRoute),
  MenuItem(tripPageDisplayName, tripPageRoute),
  MenuItem(reportPageDisplayName, reportPageRoute),
  MenuItem(teamPageDisplayName, teamPageRoute),
  MenuItem(vendorPageDisplayName, vendorPageRoute),
  MenuItem(helpdeskPageDisplayName, helpdeskPageRoute),
  MenuItem(settingsPageDisplayName, settingsPageRoute),
 MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

