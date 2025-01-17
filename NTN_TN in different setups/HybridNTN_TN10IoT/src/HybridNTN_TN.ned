import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.linklayer.ethernet.EthernetInterface;
import inet.mobility.static.StationaryMobility;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

channel ethernetChannel extends ned.DatarateChannel {
    delay = 100us;
    datarate = 100Mbps;
}

network IoTCommunication
{
    @display("bgb=1200,800");

    submodules:
        satellite: Router {
            parameters:
                @display("p=600,100");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 1;
        }

        baseStation: Router {
            parameters:
                @display("p=600,300");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 11; // One connection to satellite, ten to IoT devices
        }

        iotDevice[10]: StandardHost { // Array size increased to 10
            parameters:
                @display("p=200,500;p=300,500;p=400,500;p=500,500;p=600,500;p=700,500;p=800,500;p=900,500;p=1000,500;p=1100,500"); // Adjusted positions for all devices
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 1;
        }

        configurator: Ipv4NetworkConfigurator {
            @display("p=100,100");
        }

    connections allowunconnected:
        iotDevice[0].ethg[0] <--> ethernetChannel <--> baseStation.ethg[0];
        iotDevice[1].ethg[0] <--> ethernetChannel <--> baseStation.ethg[1];
        iotDevice[2].ethg[0] <--> ethernetChannel <--> baseStation.ethg[2];
        iotDevice[3].ethg[0] <--> ethernetChannel <--> baseStation.ethg[3];
        iotDevice[4].ethg[0] <--> ethernetChannel <--> baseStation.ethg[4];
        iotDevice[5].ethg[0] <--> ethernetChannel <--> baseStation.ethg[5];
        iotDevice[6].ethg[0] <--> ethernetChannel <--> baseStation.ethg[6];
        iotDevice[7].ethg[0] <--> ethernetChannel <--> baseStation.ethg[7];
        iotDevice[8].ethg[0] <--> ethernetChannel <--> baseStation.ethg[8];
        iotDevice[9].ethg[0] <--> ethernetChannel <--> baseStation.ethg[9];
        baseStation.ethg[10] <--> ethernetChannel <--> satellite.ethg[0];
}