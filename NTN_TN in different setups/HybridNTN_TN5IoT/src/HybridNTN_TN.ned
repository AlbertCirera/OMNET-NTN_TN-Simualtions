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
    @display("bgb=1000,600");

    submodules:
        satellite: Router {
            parameters:
                @display("p=400,100");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 1;
        }

        baseStation: Router {
            parameters:
                @display("p=400,300");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 6; // One connection to satellite, five to IoT devices
        }

        iotDevice[5]: StandardHost { // Increased array size to 5
            parameters:
                @display("p=300,500;p=350,500;p=400,500;p=450,500;p=500,500"); // Adjusted positions for all devices
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
        baseStation.ethg[5] <--> ethernetChannel <--> satellite.ethg[0];
}