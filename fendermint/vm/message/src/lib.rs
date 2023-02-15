// Copyright 2022-2023 Protocol Labs
// SPDX-License-Identifier: Apache-2.0, MIT
use cid::{multihash, multihash::MultihashDigest, Cid};
use fvm_ipld_encoding::{to_vec, Error as IpldError, DAG_CBOR};
use serde::Serialize;

#[cfg(feature = "arb")]
mod arb_cid;
pub mod chain;
pub mod signed;

/// Calculate the CID using Blake2b256 digest and DAG_CBOR.
///
/// This used to be part of the `Cbor` trait, which is deprecated.
fn cid<T: Serialize>(value: &T) -> Result<Cid, IpldError> {
    let bz = to_vec(value)?;
    let digest = multihash::Code::Blake2b256.digest(&bz);
    let cid = Cid::new_v1(DAG_CBOR, digest);
    Ok(cid)
}
