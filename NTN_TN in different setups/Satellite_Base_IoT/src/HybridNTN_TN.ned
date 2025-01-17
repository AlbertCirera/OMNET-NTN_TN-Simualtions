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
    @display("bgb=800,600");

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
                numEthInterfaces = 1;
        }

        iotDevice[2]: StandardHost {
            parameters:
                @display("p=350,500;p=450,500");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 1;
        }

        configurator: Ipv4NetworkConfigurator {
            @display("p=100,100");
        }

    connections allowunconnected:
        iotDevice[0].ethg[0] <--> ethernetChannel <--> satellite.ethg[0]; // IoT Device 0 communicates with the satellite
        iotDevice[1].ethg[0] <--> ethernetChannel <--> baseStation.ethg[0]; // IoT Device 1 communicates with the terrestrial network
}