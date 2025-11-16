import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("TelephoneCallerModule", (m) => {
  const telephoneCaller = m.contract("TelephoneCaller");

  m.call(telephoneCaller, "setTelephoneAddress", ["0xE3E4302b375d402b45816Cfd9b2D4CAC026b3713"]);

  m.call(telephoneCaller, "callTelephone");

  return { telephoneCaller };
});
