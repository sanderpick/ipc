// Copyright 2022-2024 Protocol Labs
// SPDX-License-Identifier: Apache-2.0, MIT
use anyhow::{anyhow, bail};
use ethers::{providers::Middleware, types::U64};
use fendermint_materializer::HasEthApi;
use futures::FutureExt;

use crate::with_testnet;

const MANIFEST: &str = "root-only.yaml";

#[serial_test::serial]
#[tokio::test]
async fn test_full_node_sync() {
    with_testnet(MANIFEST, |_materializer, _manifest, testnet| {
        let test = async {
            // Check that node2 is following node1.
            let node2 = testnet.root().node("node-2");
            let dnode2 = testnet.node(&node2)?;

            let provider = dnode2
                .ethapi_http_provider()?
                .ok_or_else(|| anyhow!("node-2 has ethapi enabled"))?;

            let bn = provider.get_block_number().await?;

            if bn <= U64::one() {
                bail!("expected positive block number");
            }

            Ok(())
        };

        test.boxed_local()
    })
    .await
    .unwrap()
}