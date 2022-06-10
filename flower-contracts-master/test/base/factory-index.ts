import { expect } from "chai";
import { ethers } from "hardhat";
import { FlowerController__factory } from "../../typechain";

const hre = require("hardhat");
describe("Factory", function () {
  it("Should create a controller", async function () {
    const newProjectName = await hre.controller.projectName();
    expect(newProjectName == hre.projectName, "projectName should be same");
  });
  it("Should add a module", async function () {
    const newProjectName = await hre.factory.projectName();
    expect(newProjectName == hre.projectName, "projectName should be same");
  });
});
