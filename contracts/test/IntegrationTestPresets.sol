// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.23;

import {SubnetID, Subnet, IPCAddress, Validator} from "../contracts/structs/Subnet.sol";
import {DiamondCutFacet} from "../contracts/diamond/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../contracts/diamond/DiamondLoupeFacet.sol";
import {GatewayDiamond} from "../contracts/GatewayDiamond.sol";
import {GatewayGetterFacet} from "../contracts/gateway/GatewayGetterFacet.sol";
import {GatewayManagerFacet} from "../contracts/gateway/GatewayManagerFacet.sol";
import {GatewayMessengerFacet} from "../contracts/gateway/GatewayMessengerFacet.sol";
import {XnetMessagingFacet} from "../contracts/gateway/router/XnetMessagingFacet.sol";
import {GatewayFacetsHelper} from "./helpers/GatewayFacetsHelper.sol";
import {DiamondFacetsHelper} from "./helpers/DiamondFacetsHelper.sol";
import {IntegrationTestBase} from "./IntegrationTestBase.sol";

contract L1GatewayActorDiamond is IntegrationTestBase {
    using GatewayFacetsHelper for GatewayDiamond;
    using DiamondFacetsHelper for GatewayDiamond;

    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);
    }

    function defaultGatewayParams() internal view override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](1);
        path[0] = CHILD_NETWORK_ADDRESS;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT,
            commitSha: DEFAULT_COMMIT_SHA
        });

        return params;
    }
}

contract L2GatewayActorDiamond is IntegrationTestBase {
    using GatewayFacetsHelper for GatewayDiamond;
    using DiamondFacetsHelper for GatewayDiamond;

    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);
    }

    function defaultGatewayParams() internal view override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](2);
        path[0] = CHILD_NETWORK_ADDRESS;
        path[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT,
            commitSha: DEFAULT_COMMIT_SHA
        });

        return params;
    }
}

contract L3GatewayActorDiamond is IntegrationTestBase {
    using GatewayFacetsHelper for GatewayDiamond;
    using DiamondFacetsHelper for GatewayDiamond;

    address constant CHILD_NETWORK_ADDRESS_3 = address(31);

    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);
    }

    function defaultGatewayParams() internal view override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](3);
        path[0] = CHILD_NETWORK_ADDRESS;
        path[1] = CHILD_NETWORK_ADDRESS_2;
        path[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT,
            commitSha: DEFAULT_COMMIT_SHA
        });

        return params;
    }
}
