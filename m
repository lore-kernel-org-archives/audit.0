Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084111304BA;
	Tue,  3 Dec 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196190; cv=fail; b=knSzP7+9/aHEhqwFNREeAXjit2twuihWjcTUt0fOuWHn/e4VMVYmD09x2OAzdtXni3r3Escb/FWp1xtZtn2q5rerT5jnD7wodQaVZkiONIFT4Uw0NGHhbuip4laMlcaWJW6nK/gYMk0Z/JtVQmcAyOkYs6dcMjRfF5eLfkVcGyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196190; c=relaxed/simple;
	bh=ESvYleogPWpzW5BmzJ4ovOY9bvP+/wistkZtcxvY97Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sd74WeCw/HJrgveuDCIj730/V+89ZQ8JynNB88wE/aFqm6f0Yvj8Avof+0hZBmajsn9UZp0Ebegs7RFrCtuKJ8efJ7qVm+Tl4s/3dwvTmQ+vX0DF81VJh9hn56tkX3xcn2AlR6IAtYS0XeaSn8/fdRuIlVJJSRLfyxHhqDDfPnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixRhRzMB; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixRhRzMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733196189; x=1764732189;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ESvYleogPWpzW5BmzJ4ovOY9bvP+/wistkZtcxvY97Q=;
  b=ixRhRzMBy61RlaRIquo3uU5h5V3h3km/VgIQoJ20IYKfuJXQhZPWIYhG
   WDm6qlpvw5Dv1svr+9DG8Of7vIvFTc7RD/wUiS/JRppLoNpmkmDWNNXU8
   6tFcBSBGi3K39TEkFAMX/04xj4flObXCD40CyJfnn5Rok0SgoffuMhAhT
   jASgfCZxDawGtWS281W7GlXf3Q+cx99fpVvNDAg+yza4V7wbpspF+wt7k
   6ifyPITlxmbPqybAaxqQeKOWADCjtQnKlvXX/8tjQ3rbts4//unhYGrau
   K90jZov04vuc0KGJDod5vnYtvp1HqecpSHo074eScM4kTXr3swI52CJkI
   A==;
X-CSE-ConnectionGUID: lB/Ohq//TSamRbgDyERHdw==
X-CSE-MsgGUID: UVrV3h0yRo+1xuC3DtX89w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20979615"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="20979615"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:23:06 -0800
X-CSE-ConnectionGUID: UpFGVnhoQ0GAcpC/0oM5+A==
X-CSE-MsgGUID: dzN5JvKLSHG/b1AetyOCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93384809"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 19:23:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 19:23:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 19:23:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 19:23:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV5Cu2lgkLmUSKWs/dMimv+MUeVVC/YXERuX5Vf/vxcB8+XCHVwXlX2qJnFl/MW+bbBLuK6Vj9mbTYIwiJkk9ri0ycOsS+H6VOqZdU8smVmqfQi+hFrNmTqZFgDbR5wkgASBT8FY1TuypQYg150vp1R4hRmB0LYWHsyg8/UhG2dhFBa+nzAvNj7owwsLBu5TK2sHgo93DVMnPfoPqaMXj9jh0nNgEaqzGlgm6w3wGYf7/uV64ywuXe+Whwsfczc+9F2f3uEuxoDNxqKbBn4DcRabcYwaWyghPug8tVlN1JNRQMaEUUVHB4dU5Z9VFIB1T0XRRooIxIc8LxwGM2z//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uefWsnG9w5K78ZiLY8ZkMEaHjJu96dAdcoi372/yMDA=;
 b=Nry5My3As3g2Sx2TBFU+vYY3xuvu4ETnf2eatZ7TITKSKbn3/kQMmh5awEBvtTxia6rBsw87piY4JmlKKSkgWgE7EUybAiGFriVD9FxI1c8pgocH6LHJCy3UvO9ymQVgcYpzdixE5jv2zzcpEm4RsaG0jxKW2rjkDt3LevpSCVQdyRqqiZ/rXjw0t5lW0em24sZs3TD5PK8GthsSW8BDQlNUbaMcP3VyOZbVdZe29sm5RxrWmbRsNaQ72HD9Q6D/Li0OcOtluq4q7iyrwj42KP6wnnzZyguX3obNEvF9vWtI2qxqTAFZoWnSXmlnQO9rl9hKxuMsBVjcia2DAuodRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 03:23:02 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 03:23:02 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
CC: "audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"laoar.shao@gmail.com" <laoar.shao@gmail.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>
Subject: v6.13-rc1 build errors from kernel/auditsc.c 
Thread-Topic: v6.13-rc1 build errors from kernel/auditsc.c 
Thread-Index: AdtFMqG7VgRim24/TTSgooMp4H4J6A==
Date: Tue, 3 Dec 2024 03:23:02 +0000
Message-ID: <CY8PR11MB71348E568DBDA576F17DAFF389362@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7675:EE_
x-ms-office365-filtering-correlation-id: d9163112-4493-4b3d-24de-08dd1349cb53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YLmgYMTzwD26/FllmK1ZtVU8hdWZTykjaDfjPMrzFXQuMjxm3zTryZWB4Ygv?=
 =?us-ascii?Q?CBbI/ISwMmZ46MYnhPRQ6FpONRNN+YT7+zB4iDXp+YhFXLTxVpUn4mUGoB8X?=
 =?us-ascii?Q?aEeYWIM5wNJKxbivBZ5L9J+4XPQbJHFFxpzPIeZnoIT26INi+bWR+N+Q3nVL?=
 =?us-ascii?Q?BmI9YZgl2Yb7vf2LRkKGbPzIkhZ5dYayLMA8Bjqt93hG8rGX4cGQfJmzH9YB?=
 =?us-ascii?Q?F0yqFG/tERx2fLnu+zoNkYl7GjVYb8ppy0Wld5Wcr6CFqYmBPh3zDO3BX2PM?=
 =?us-ascii?Q?aFi3BIs8greetdJWqWWiVomvpVOG3s4YmcY/B4lDer1NzjFKz478LbZKpSm+?=
 =?us-ascii?Q?dY+pfHoRwUG4MYvnWn/yZUMS4OHz49r7Gnc2tbByp4C67Tw2OFdHYMJN0PeG?=
 =?us-ascii?Q?D9G9yxAwGNptGP6E4yNIiQjs58wSIVHvSLUPMMZfoWAQSEBDzz2qAjw24lSp?=
 =?us-ascii?Q?7E0dI57xlI+Ljg2bbnek1+uUOT+tHVyZVFRZpPjqM5tYmo25v6/aUO4KJtxq?=
 =?us-ascii?Q?FUvKgvIPRnprEdbZxGsjrZ8aEPtUtSsEwrU9FkZLsiw39OGImSbJvn6zqgJG?=
 =?us-ascii?Q?QcoF9CZbg4LzgQoJK1UBLOyRbHlATw0tP/6qJ5wG8pd3ie23pAVL9F6h2Av6?=
 =?us-ascii?Q?Zs/BGZy68AKacl5+tPgCuowdT6E2somDE5myiTvW5pIoRk6sys59cDkNCd4k?=
 =?us-ascii?Q?z2VX2JD5U/fFW+fBFbgxNMv2UTbCZ/y4CDdFVOCXRY7CZ/bzTXSs/cVjsoQZ?=
 =?us-ascii?Q?x5kraxBMtEZD4fswWPGUabAOvxJQlzi2AL8sNVsjCw1P2oYmdCdYKCYlCEGP?=
 =?us-ascii?Q?FRgkeNjJ/zZp9ZNI7Vw2qnS/xeb8SZ7rpQJ6jlP+Mp6UMdqdKs5LHBGt43wN?=
 =?us-ascii?Q?+GjChoGKRhPdSVW0EbvpvJAgxYzCObmkCHwecHGUzY47pUgO0w7NG7TdMbva?=
 =?us-ascii?Q?VkvKkbGKA5FUhvN8pLgtQp88w08kCxEd4NBbBLKaNzEsklhkE0204vzDkDa8?=
 =?us-ascii?Q?az9PIKPTb/FncKsZeyCks36PPhawit9YL2tBm4DDd/11f6oE5XPZj0fnnl/Y?=
 =?us-ascii?Q?66hUdkwQN8ma1xe/54Bw2F7iHm1uxLZWQeQvkFb+jumfxdCK7/p47BorRN+k?=
 =?us-ascii?Q?hzNoVCkdeWEOan7ufjdi0yy4bHozuiBzxGCIRupTg83ccMhdYD5Za73/5j89?=
 =?us-ascii?Q?PRAkk5dOw4qIZjIdjKeThnv9ptxmtP3QDZNSsYGp9sLjWpo1MpC9tUgNBdTq?=
 =?us-ascii?Q?d5OOuReZL4wlvekfhyQBA+31ZSQK9U7ze+2ZwiRpeSxlHtW2j70jO6A2xI4e?=
 =?us-ascii?Q?GGlxvJ4gY0V3WYKfgbOc08d4f1WEFXjH7GWYPmpnLS+bmYdmGyXcO4kWdZBo?=
 =?us-ascii?Q?RWP4VoctHZezIJ72S9qTmpajO4r1xgM0t+EDebFrVvv8HUiqGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7rEvKy0BPm2nYIWi+irLqMwVV0YPuzAXlYtdteYid9SjfM2lJwataaK3U2RQ?=
 =?us-ascii?Q?s6aZZkhJXmrEqeBGJE39e+ez0Ubbjxpnp1ni76kjul5HV1j+7MVn0zuBKwyR?=
 =?us-ascii?Q?fHiRwrHYQCwb/BNgTVgPf6PdwY2zUFksFQUBRzkZXtFkUujgZMZgzXFcMdBv?=
 =?us-ascii?Q?iJTVgIFBkYTwkgXyib4/rmSUiN9zdTGrKpJ9sgDk7g8V7L37x1nQUHgVe7hU?=
 =?us-ascii?Q?H1l8TYya1rhgjgT0Ke4QoPGY8WD9byB4CjoNyLmCD14YPVHTvQP5ieirL5j+?=
 =?us-ascii?Q?P2POE82IRMsbNlnPWbIadtDnkV1opJZd9ED4fxFRIsGBDDFkg7v6ZLrq2Dk/?=
 =?us-ascii?Q?VH/twQYPNUVrkY8wtVUraF/1h9fIznlAFsFa86T3EW3hBBYdi0sx3dJwFxYn?=
 =?us-ascii?Q?KnxbT7PnpnsLADIEvR1ReE1dMunEUshDQQA2hpmvhxwEObrYCcAcmVmFYQkz?=
 =?us-ascii?Q?0Dcm8PoDGphRZKqjDkt9AEIcTJ3oa2FCEw0hQyxU+gOpLwM6xv6lddjOn5a3?=
 =?us-ascii?Q?omDOfl72UKsuFlV1q9jOYJc2pYnVPPELCnj/SzGo1uf4ZR0IMoqiTg4CxgbI?=
 =?us-ascii?Q?6YYnOE6Ils/D8mQU/ErSj/3BiKoseHm/6AMfb8y7kWRzJaagElu+EUdHvzlR?=
 =?us-ascii?Q?aYRNElMz7A9SMvBIHnQipZdEwGB4DEdKGAk3gnDjWra/X3QEKWbDEYF/hmEw?=
 =?us-ascii?Q?I+oW6csmBJixoD0UgUMMyfOgcQuJp4h0aKumyZ3yVgZPoVmd6BumO5CLmi3L?=
 =?us-ascii?Q?au78KTvtqUrktLPNeG/5eArBtXwFbNNbbBNCX2XpR+ZG4mexiMC2jf2mZlb0?=
 =?us-ascii?Q?FfbegK4LegI68RJEJrSr9etvJWuJw1fgDevshtukcw8FcKeLGpG+lKMXy/v9?=
 =?us-ascii?Q?an9ae8LV04L/xYOicptF+9pfJoWfJVEnrR+p8eNSdLMl/UdYPOo7l/z6cqNO?=
 =?us-ascii?Q?hhgxw7/67hCBXrEcyksUpzhZJg4gHJ7Gg8QLAk0l3KJ3VA3/0XSNhAfblPqS?=
 =?us-ascii?Q?naV5abLfp3gaX2NA9zwQHJlEjLD/lp8GZ/kiReNawZQ4Sxc0EIy12zar42FO?=
 =?us-ascii?Q?oYJ7xqymWRQMXU3SJMcF+g5hhvv4KmFDO71nI31pRo3CPdx9pZDb29T8KbDE?=
 =?us-ascii?Q?QNp+G0mV4OEESM1Bn8cenNn4VvwXOKtm/RRmo7XvcnSnDFniZBb6NH45E9Rx?=
 =?us-ascii?Q?EqT6BrH0SgFcZMTRho9UmbSu+zjPSCDTqqPAjxaziqW6dSsqX6pz5n8uzpee?=
 =?us-ascii?Q?k2QGemvc5dP1YtLbLpxVMPxB0bLbiEnWeLn95nlmyMGCUV/BIScEaIhFNdN6?=
 =?us-ascii?Q?CHTzE8OxripHQ3W+MVigo45OqwcYpvwZMyvrjnSVc88x04VQChs+paPj57Jk?=
 =?us-ascii?Q?HEJmZxgbzf9JZ0rXfNB2XoDJCK0GVwqMivMrBps/N8wS0JSGY4fhYsW9pS8g?=
 =?us-ascii?Q?NzTTYQdGpbdkRHpAGrjxE/J/SdqA31LwtNrmT7HtNv2KN3JstPNKGoB+OnmE?=
 =?us-ascii?Q?vQak5s3ayZ1A/mrN7GiGMVhJ0vg2pzVC8Fdd5ZhpNdR8rqwI4oPpDTpAUAyE?=
 =?us-ascii?Q?m6yH+Xkb6Yb+CzgA1nc4Ggu95rtYD7/X6p9BjJPr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9163112-4493-4b3d-24de-08dd1349cb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 03:23:02.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvlzB+ASDxXtbOSDKdBA0GmirXtoEpgu0jWd8iPtknbBT68sS8l71w6+eUcsPuBzyHsjJzzMfUOlBAs04MUyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

Hi,

I got the following build errors from kernel/auditsc.c file.

The GCC version      : 7.5.0
Kernel version         : v6.13-rc1
The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with strscpy()=
")

Build error logs:

                 from kernel/auditsc.c:37:
In function 'sized_strscpy',
    inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
./include/linux/fortify-string.h:293:3: error: call to '__write_overflow' d=
eclared with attribute error: detected write beyond size of object (1st par=
ameter)
   __write_overflow();
   ^~~~~~~~~~~~~~~~~~
In function 'sized_strscpy',
    inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
./include/linux/fortify-string.h:293:3: error: call to '__write_overflow' d=
eclared with attribute error: detected write beyond size of object (1st par=
ameter)
   __write_overflow();
   ^~~~~~~~~~~~~~~~~~

-Qiuxu
