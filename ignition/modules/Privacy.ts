import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { slice } from "viem";

export default buildModule("PrivacyModule", (m) => {
  const privacyAddress = "0xAbB7Ddb7c1BFAC0e24abD4e149fACda79EEf5243";
  const privacy = m.contractAt("Privacy", privacyAddress);
  
  const data2 = "0xfbd37caec18b8fd856cc21ab16c2516f5559746741914d9b2386f637d2664e65" as `0x${string}`;
  const key = slice(data2, 0, 16) as `0x${string}`;
  
  m.call(privacy, "unlock", [key]);

  return { privacy };
});
