import "./interfaces/IFactory.sol";
import "./FlowerController.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.4;

contract FlowerFactory is IFactory, Ownable {
    mapping(string => address) projectMap;
    mapping(string => address) platformModule;
    string[] public allModule;

    function newProject(
        string calldata projectName,
        address owner,
        string calldata avatar
    ) external override {
        require(projectMap[projectName] == address(0), "project already exist");
        FlowerController controller = new FlowerController(owner, projectName, avatar);
        projectMap[projectName] = address(controller);
        emit LogNewProject(projectName, address(controller), avatar);
    }

    function addPlatformModule(string calldata moduleName, address implement) external onlyOwner {
        if (platformModule[moduleName] == address(0)) {
            allModule.push(moduleName);
        }
        platformModule[moduleName] = implement;
        emit LogModuleAdded(moduleName, implement);
    }

    function getPlatformModuleImplement(string calldata moduleName) external view returns (address) {
        return platformModule[moduleName];
    }

    function isPlatformModule(string calldata moduleName) external view returns (bool) {
        return platformModule[moduleName] != address(0);
    }

    function getProjectControllerAddr(string calldata projectName) external view override returns (address addr) {
        addr = projectMap[projectName];
    }
}
