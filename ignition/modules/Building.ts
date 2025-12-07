import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("BuildingModule", (m) => {
    const elevatorAddress = "0xA2670acD50364EA2Efd6E0AD8faaAA7Ca9A5CDe4";
    const building = m.contract("Building", [elevatorAddress]);
    m.call(building, "goTo", [100]);
    return { building };
});
