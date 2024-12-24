## Switch ex 
These files implement basic switch features.
### execute:
run
```bash
./execute_switch_ex.sh
```
### Implementations:
- Packet Filtering:
The program uses a table-based filtering mechanism (filter_table) to allow or deny 
packets based on predefined rules. Filtering is an essential feature of switches 
for controlling traffic flow and implementing security policies.

- Forwarding:
Packets that meet the filtering criteria are forwarded to a specific port (OUT_PORT). This mimics the fundamental behavior of switches in directing packets 
to their destinations.

- Dropping:
Packets that do not meet the filtering criteria are explicitly dropped, and the event is logged. This represents another core feature of switches,
which is traffic control.

- Logging and Reporting:
The program logs forwarded and dropped packets and generates reports for packets that match certain criteria. This is helpful for debugging, 
monitoring, and network management.

- Programmability:
The use of customizable event handlers and tables provides a level of programmability, which is characteristic of Software-Defined Networking 
(SDN) switches.

- Basic Event Handling:
Events like packet_forwarded and packet_dropped encapsulate key switch actions, enabling modularity and extensibility for more complex logic.