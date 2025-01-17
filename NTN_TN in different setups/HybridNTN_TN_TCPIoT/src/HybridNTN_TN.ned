import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.linklayer.contract.IEthernetInterface;
import inet.mobility.static.StationaryMobility;
import inet.applications.udpapp.UdpBasicApp;
import inet.applications.udpapp.UdpSink;
import inet.applications.tcpapp.TcpClientApp;
import inet.applications.tcpapp.TcpServerApp;

network IoTCommunication
{
    parameters:
        @display("bgb=800,800");
    submodules:
        satellite: Router {
            parameters:
                @display("p=400,100");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 1;
                udp.typename = "Udp";
        }
        baseStation: StandardHost {
            parameters:
                @display("p=400,300");
                mobility.typename = "StationaryMobility";
                numEthInterfaces = 2;
                tcp.typename = "Tcp";
        }
        iotDevice[2]: StandardHost {
            parameters:
                @display("p=350,500;p=450,500");
                mobility.typename = "StationaryMobility";
                numApps = 1;
                numEthInterfaces = 1;
        }
    connections allowunconnected:
        iotDevice[0].ethg[0] <--> ethernetChannel <--> satellite.ethg[0];
        iotDevice[1].ethg[0] <--> ethernetChannel <--> baseStation.ethg[0];

}
channel ethernetChannel extends ned.DatarateChannel {
    datarate = 100Mbps;
    delay = 1ms;
}