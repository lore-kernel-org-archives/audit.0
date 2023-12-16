Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451630657
	for <audit@vger.kernel.org>; Sat, 16 Dec 2023 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qx56Co/g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bATOlQE9"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGFe3DE013235;
	Sat, 16 Dec 2023 16:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NE+ztgva75tuB9dw+y77oT2LqFYLpncaLAw+V3pEakU=;
 b=Qx56Co/gNzfqfSt5lp1Fc71f0vY9asa4ThOPq+w7oGz7cyTU+PzKKIlV9afEgOigp2D5
 saTI/XJQKXBJpOAcLlFGf/aAYTOMwpe+Dnek1Vhhg6av+N/p6s+R1Xv7A3kgop15+00x
 edtE5jrnIDNdxYSFsaxNqvGi53Lb+xrPqr0gi9jXV770+1OW7ruPKGF5IxWURwOAYpPx
 WjZdA/r0H0IvFtvTquVF/IDJILf6+N4fdRVDdUra56NEZ2WXVEx1JVp+7Jq2m35lrDT2
 +az7+9jrM1ucLbn+KTjjZt3l2/0W5fcDXBRESUYPQWQbMLwmj7SssWM7Ln11EakeoY4i MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12ae8rtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:28:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGD0Q0C027416;
	Sat, 16 Dec 2023 16:28:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b9jfbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWwW3TnrhuLiurjwzRO3XIuPpIqRJqVez6HFuh4wQKhfIG8HqNlUBBwEZALyPyiaGh8HsvwiGd5BmDlCF+sN7DCzj5UEjPFPpVaxjg+dw0zWXcXCCAXlYhZqUTq8Ol+uiYjLLmzhbc0QJINljh3VNCTwC4xhBOtBBZsbiSnaWGNvusFskZt9/wouL+QM8zMmdx+0ehE+9vb1PSI+riN4mOBicDWib6wUgEAfTvzPnW4ZVRSbtHpTKcpc9BOGa/RPglFCUcmjueA53Ojr1aaTftKoSw+Aqzx40I8JfayMHe3H6jhGW9UD+aWlaXi4HD5S/c5OG+9697e9eK9D8gkoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE+ztgva75tuB9dw+y77oT2LqFYLpncaLAw+V3pEakU=;
 b=P/6kRxEVraXpTx5Kjl1UUAN88tM/6dm6sQW8OBEK+yewY5M8gLY+VBUazN7WXEDBavmQGnf/p/Jxy0EkZn3qFn8LCVIX3Y6wVpbPeBU6Yjlzu3O1b9QJH7gIVwqPYLooLdMpBTWL0egbjTt65nLnacGRCCQ5mNJr7StJH71qBrzEwCO+tqQieZiS/oCK7uI+WKdUTQhxBo/HU3Ir33co03m+jdHz0XIlLlu9NHNHtrzQuQJweIDquH7/y5Lpm1Jtb992yv9IfQzJcb9XDFlvGrInsC8PnI6t2uRnLk4IFDuhx6Zq1hVeXGZsFuyVTtwZUKq1lTai06wayxH7AJ9p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE+ztgva75tuB9dw+y77oT2LqFYLpncaLAw+V3pEakU=;
 b=bATOlQE9LrjDIlDThewS20eUbOXw3cEW/antl+xPjO/HliWXRZnEe6YDm4ODNbVtF3EockByoXrk1A/OumRSyJ0vWMdUYUcVeCLfP2IRZvIgxpWSbnGN/TLeAfO6jITtu17t2+Qxi0jXU73l77d2JC6fYPYCkacC0F1bTed0a2I=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Sat, 16 Dec
 2023 16:28:13 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0%5]) with mapi id 15.20.7091.034; Sat, 16 Dec 2023
 16:28:13 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Eric Paris <eparis@redhat.com>,
        "audit@vger.kernel.org"
	<audit@vger.kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 2/2] audit: Apply codegen optimizations
Thread-Topic: [PATCH 2/2] audit: Apply codegen optimizations
Thread-Index: AQHaLh58sc5YvNqF2kWi0fPrhBBXabCsHXAA
Date: Sat, 16 Dec 2023 16:28:12 +0000
Message-ID: <CEB5B23B-7D1D-4C7B-B8A6-CA07239CB5EF@oracle.com>
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-3-haakon.bugge@oracle.com>
 <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
In-Reply-To: 
 <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|PH0PR10MB5896:EE_
x-ms-office365-filtering-correlation-id: 88ec1ff3-4119-4402-59b4-08dbfe53ffc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jqUJiqlbQq1b+jiGIrg6SE7hpvVS8xqJQEkOZbM3cAIls4tfZxFaE6nKmYaVBnkOe63MiTeREXEd3mF8tE2ivR8uxfg0bt3bM5R1z4b7SJZFgix9CgrDJk6wBYPveeYnrIamjKNvjcWOdEkNGrM5Hfjf6TI59NCaCcQhGZxIiq8t8xGLVHyAdok2a7/oex11heXH5/ZNqv7lnFwaMVKbNWMnsBM0t7qa+6u+bS8w+xxLe6tHCp/ks1snR6CNaQHeOQ+f+gXfRHVWNOTlqDJIq4E/6hh61B9tp90edkStYaTRGHm8T0tQG8X8+ZDVYSibQKD26GkTshVwxwdtrdD1HSSYkEAMkuvUQ07DYzemstvTBZ471PWIA+vpyxHssHYhXvFdxH2nq8JmPFbhoVzEpw4Ko3FV6i/yeG5yl/RdzZnCTKhxRS2VnXUWrbfavHdQEfogxJJY//M36oIp0KhQsTQ0/FxFPO2nTLdGpgIw15tWErBnZd9/6JocWsCmLk0EDGPTuz1HihkyDf3FULF9t3MhG3XH0qe18kyOC0VPfjud1QTMcTLAatquroblKM3tBzPSLlD+DIOOS5CZf7wADGajHJ9bOkJ1Rd9EB5EB7K9gOjOLWTqzB9ergyV51FriLijkC2cJbVwU9QSM67TOoA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(71200400001)(6486002)(8936002)(8676002)(4326008)(107886003)(26005)(2616005)(478600001)(86362001)(83380400001)(64756008)(6512007)(53546011)(66946007)(66556008)(66476007)(54906003)(66446008)(6916009)(316002)(76116006)(66574015)(91956017)(44832011)(5660300002)(6506007)(38100700002)(36756003)(38070700009)(33656002)(41300700001)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VzBNaDFJWk5FSEY5SEZuMnU1UnlQcC9lK1JXVkN1ZkQwNGxRQndiSmY2OEpX?=
 =?utf-8?B?Wjlzc0tXYkE3Vm1KRkhkQnZTeE8vLzZyVWpFVkpoWDc3TjJvTTE2aUxQS2dQ?=
 =?utf-8?B?Mm9HWk1qS2FWRVYyM0ZpQTFjRXlJY0Q4R1U2eElTZVY3cXIzdHlyekxKZWRG?=
 =?utf-8?B?aUtpaDdCWFpYYWRyRisyaS82UC9ydS9sWlRXczVMcDd0UWUxMC9tN2srRlgr?=
 =?utf-8?B?ZmJ5Q1BOcytMKzBqcUpJc3JVSG5tT0xzeHJNSGp5WU1tb1Y4b3lwQkttZDM0?=
 =?utf-8?B?Z1lPbzkydE1ZTGNSYlJrZ2RiSVp3ZXRoT1czUlBzWS9OaEczSEVlVDlYMUMx?=
 =?utf-8?B?MkU4OFFOc1hNRTBraE9MWDh5bVgyRUZKeXJjUko1djZsZ0p3V09wYnFLWEVt?=
 =?utf-8?B?dHYvNGc0YS9nM2N1d2xXSzdqdnFpTS9teDhzUFg3L1dRMEtZR3QvQW1kYWRO?=
 =?utf-8?B?b0ROVFZXMWZEZGI0VXprUDJZaGpqdURtNG1rK0l1MFV1MlFrSkNjYTFscms2?=
 =?utf-8?B?ZmNaNnA5SjFFRnBkSHJkVVhqZVFXZVNoOTlJUGt6WVlHUlU2dDMrRkJ5UEVi?=
 =?utf-8?B?MWduRFJzeHo2dWl0T2M1My9CUGVUK0xQc2dYVFRkTTZxT3E0dHUzS2dHTDl0?=
 =?utf-8?B?TlIxc3h0eXkyM2M1Vy9peThBS0FnR2c1aHdtdnJKYkJySTIwK1paWWxURlo4?=
 =?utf-8?B?b21iSTk4NU5OR0h4UVF6R0pSaHZoOTg2OVREK203WkhhazhOV1lUQythR244?=
 =?utf-8?B?L05JY1BNWTRPeXlIay9yQjd4NHhvdk12SHdFWGNxOTAwTmk1bDY4cUJhUHpT?=
 =?utf-8?B?aUlsWExJY0I4RlNYMWduakNoUkVFU3VPNk9uU3dqd3JSbWZlOHNKVXNQN2hr?=
 =?utf-8?B?TVk3YTVIUjR2WXJ6eEQ0QVdQalBhZG91M04zR3piaUt2N0tRT3h3L2dXT3Fo?=
 =?utf-8?B?UjRZWFdSSlBzdk9qUXF4SDU0amlIUWlLeWpoMndIdzlreDdzNkJRYW1oN0Mv?=
 =?utf-8?B?Rmt2cUYzMEhIRWp0Mm9relU3aGlpb2FHSlg1cVI5c2ljalh5RVErNE9oM01X?=
 =?utf-8?B?TFpwWTd1Rzk2OHlJcTZHTlVVSTJqSkZXMGgxRGM1RHZuOVk4TzZpTHA2N1Fu?=
 =?utf-8?B?SVlmUm1RUUxocFdPWGdhRHpNb3FBYUNTR05rZXdmMjQrVFJhTk9VQWZWRkVW?=
 =?utf-8?B?dmNjOThpd1F4TXpZZjdwQzB1QkNkTDQvejRFa2pPRTJFVG1RSFN3alp3WFVH?=
 =?utf-8?B?OTI3WEthcmliY0h2NkRNVmNTUDdITUx0VE40eHVCY0xNTkQvS3dqaDcyT1Nu?=
 =?utf-8?B?TndHMkpIdGxhWUR6Zkg3amhkQlY3dHRpT1hPdXNnb2FqL1p3WE9hR2ZQSVVR?=
 =?utf-8?B?U3dBVXA2VWw4Z1ZYVS82Rkt2SFQ0MWliMHN5WFhYR2p4M1ZoRVVhcnpUd0Uw?=
 =?utf-8?B?Rnd1WWt1UlJ5QnlTZ1RiOHA1UngzdWt0bnBQSCtXeVNuMXkzUHZRc2UzbWFk?=
 =?utf-8?B?MWoyZWRsZkFIL3hNNG5xN3NhRkZZYzNIcWt1Zk9heUs1OEYyZTFtdzNTbU9E?=
 =?utf-8?B?V2VjSEJoaEsyVXVsc0FTSGQyTzZSNFdPN05HVzMrSHBPNjZmZGV6QzRyNnpH?=
 =?utf-8?B?UHRmMXFTdmQ5NjFjcWZkUVhxUndHMGxrc0diMkZ0NzF3ODB0dnFyQ1g4V04w?=
 =?utf-8?B?MWlTUUVJK0pLRmd5ejN6R2wrNjhlSGlJdWVFSnVTRnE3aGVNWE1pYUZvVEFu?=
 =?utf-8?B?VmwyZG1UQkl2V1dvc2tKd25jQ00xazZoaWtad3laWUdxUTdiUHh1Njg1WjIz?=
 =?utf-8?B?cE9NQmxzbWlHQ0U5YkV2TGdrQjRPeXdTS051QngybjR1WXY1N0wwNitpN0Jw?=
 =?utf-8?B?SG8wUTFpSEZkRzE0dllUeXBVTzhIWVhzeGp3WW5SOEIvcjFMRnJOMUlqd0RJ?=
 =?utf-8?B?d1VhNjZCaVZDdGVyK2xwMTVaaXJvZU90dUszb1FrVmxTaVZ5WlNDb3lndlg2?=
 =?utf-8?B?MzlPM1JUTEw2YzVSc3lMREVjbmxEV0NyUjErQkNmYWUvTE1NWXlqZ3paV1hR?=
 =?utf-8?B?YUlpR3hEZkgvYld2aktnRFJNZDlqMWYvS0RtVmhhbWVOYWRRdDlWSE5GRzJm?=
 =?utf-8?B?WEtPbDVwUzRWZEcySjU1WXNDN0RiQjZJbEdyTHI1ZVZGVG1FKytIS1Q1ZzEy?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55ED5DBE4F385E4F9DCFEEFCCFA64A32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TNHK2HxQOJL6DI+x1kCEiKZ/eBfxEx7WJ3ZdZzwe8KpEfE4+lxxtxD8k5eoICVAskSbL63q8gcbxTPT0UobbU8SjhaHJ/C1f2sWmecs40xH3b2XRveWmat35y1RFMPTYtwlNnLEp266EH0bOt71i1O1gBiVkCs8Y3NoRTsmomKPznjreMd5WirdX/4cEp4uEjfSa3JKOlvARt0QqwXmPsnCk/fvSbqz9FRT/2Udo081h71s6Kjij04EvYmESzdFvPniruUNSSQRfdgR+eBB0SlvldZrjaJuuBT7CtBZyoNdwnU+QIfowkxtInqmxff6eEnGIiXk/AIDuY9hwJWpIXRsE6PT4nRabLLSimJKi4GeV8AYu3YIEJpfW4ZtHbWs6e0F+DKkqf6t2TF2WQ011JEM2tbAVmeG0x7/Z+dbqzqARywdlLz9b5xyJ4I+RKsvrdjjjxsbh7hsZ+ym/O8LJjroJCHwoTBUkrRjWjilYbsBRIqyhsaxnKWKKdpiVfOyV5+OwpnZFP8qMFfoI4tWx4BmUYe/BaXJkVgyPn3oS+4EWEJaj8Q+i+Akbi+ofNKD55nRkYydO4Vnoy+5mYeMK8MOY3yeyzlCcC1Hsi14mYJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ec1ff3-4119-4402-59b4-08dbfe53ffc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2023 16:28:12.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUZHFXJh+ikfAWTGKRyTnYHWDilS+4rQPyFIEIax7bm+359TIgclpbOZKTjGbRbNm3nC1VDeqsqmwHK+Em39FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312160127
X-Proofpoint-ORIG-GUID: HRzA0iju7e-1TbmdkoLzHbTrP0638rYJ
X-Proofpoint-GUID: HRzA0iju7e-1TbmdkoLzHbTrP0638rYJ

DQoNCj4gT24gMTQgRGVjIDIwMjMsIGF0IDAwOjQ1LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDU6MjnigK9BTSBI
w6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gRm9y
IHRoZSBtb3N0IHRpbWUtY29uc3VtaW5nIGZ1bmN0aW9uLCB3aGVuIHJ1bm5pbmcgYSBzeXNjYWxs
IGJlbmNobWFyaw0KPj4gd2l0aCBTVElHIGNvbXBsaWFudCBhdWRpdCBydWxlczoNCj4+IA0KPj4g
IE92ZXJoZWFkICBDb21tYW5kICAgICAgIFNoYXJlZCBPYmplY3QgICAgICBTeW1ib2wNCj4+IC4u
Li4uLi4uLiAgLi4uLi4uLi4uLi4uICAuLi4uLi4uLi4uLi4uLi4uLiAgLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uDQo+PiANCj4+ICAgIDI3LjYyJSAgc3lzY2FsbF9sYXQgICBba2VybmVsLmthbGxz
eW1zXSAgW2tdIF9fYXVkaXRfZmlsdGVyX29wDQo+PiANCj4+IHdlIGFwcGx5IGNvZGVnZW4gb3B0
aW1pemF0aW9ucywgd2hpY2ggc3BlZWRzIHVwIHRoZSBzeXNjYWxsDQo+PiBwZXJmb3JtYW5jZSBi
eSBhcm91bmQgMTclIG9uIGFuIEludGVsIENhc2NhZGUgTGFrZSBzeXN0ZW0uDQo+PiANCj4+IFdl
IHJ1biAicGVyZiBzdGF0IC1kIC1yIDUgLi9zeXNjYWxsX2xhdCIsIHdoZXJlIHN5c2NhbGxfbGF0
IGlzIGEgQw0KPj4gYXBwbGljYXRpb24gdGhhdCBtZWFzdXJlcyBhdmVyYWdlIHN5c2NhbGwgbGF0
ZW5jeSBmcm9tIGdldHBpZCgpDQo+PiBydW5uaW5nIDEwMCBtaWxsaW9uIHJvdW5kcy4NCj4+IA0K
Pj4gQmV0d2VlbiBlYWNoIHBlcmYgcnVuLCB3ZSByZWJvb3QgdGhlIHN5c3RlbSBhbmQgd2FpdHMg
dW50aWwgdGhlIGxhc3QNCj4+IG1pbnV0ZSBsb2FkIGlzIGxlc3MgdGhhbiAxLjAuDQo+PiANCj4+
IFdlIGJvb3QgdGhlIGtlcm5lbCwgdjYuNi1yYzQsIHdpdGggIm1pdGlnYXRpb25zPW9mZiIsIGlu
IG9yZGVyIHRvDQo+PiBhbXBsaWZ5IHRoZSBjaGFuZ2VzIGluIHRoZSBhdWRpdCBzeXN0ZW0uDQo+
PiANCj4+IExldCB0aGUgYmFzZSBrZXJuZWwgYmUgdjYuNi1yYzQgd2l0aCBib290ZWQgd2l0aCAi
YXVkaXQ9MSIgYW5kDQo+PiAibWl0aWdhdGlvbnM9b2ZmIiBhbmQgd2l0aCB0aGUgY29tbWl0ICJh
dWRpdDogVmFyeSBzdHJ1Y3QgYXVkaXRfZW50cnkNCj4+IGFsaWdubWVudCIgb24gYW4gSW50ZWwg
Q2FzY2FkZSBMYWtlIHN5c3RlbS4gVGhlIGZvbGxvd2luZyB0aHJlZQ0KPj4gbWV0cmljcyBhcmUg
cmVwb3J0ZWQsIG5hbm9zZWNvbmRzIHBlciBzeXNjYWxsLCBMMUQgbWlzc2VzIHBlciBzeXNjYWxs
LA0KPj4gYW5kIGZpbmFsbHkgSW50cnVjdGlvbnMgUGVyIEN5Y2xlLCBpcGMuDQo+PiANCj4+IEJh
c2UgdnMuIGJhc2UgKyB0aGlzIGNvbW1pdCBnaXZlczoNCj4+IA0KPj4gbnMgcGVyIGNhbGw6DQo+
PiAgbWluIGF2ZyBtYXggICBwc3RkZXYNCj4+IC0gMjAzIDIwMyAyMDkgMC45NTQxNDkNCj4+ICsg
MTczIDE3MyAxNzggMC44ODQ1MzQNCj4+IA0KPj4gTDFkIG1pc3NlcyBwZXIgc3lzY2FsbDoNCj4+
ICAgICBtaW4gICAgYXZnICAgIG1heCAgIHBzdGRldg0KPj4gLSAgMC4wMTIgIDAuMTAzICAwLjgx
NyAwLjIzODM1Mg0KPj4gKyAgMC4wMTAgIDAuMjA5ICAxLjIzNSAwLjM5OTQxNg0KPj4gDQo+PiBp
cGM6DQo+PiAgICBtaW4gICAgYXZnICAgIG1heCAgIHBzdGRldg0KPj4gLSAyLjMyMCAgMi4zMjkg
IDIuMzMwIDAuMDAzMDAwDQo+PiArIDIuNDMwICAyLjQzNiAgMi40NDAgMC4wMDQ4OTkNCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4N
Cj4+IC0tLQ0KPj4ga2VybmVsL2F1ZGl0c2MuYyB8IDIgKysNCj4+IDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9hdWRpdHNjLmMgYi9r
ZXJuZWwvYXVkaXRzYy5jDQo+PiBpbmRleCA2ZjBkNmZiNjUyM2ZhLi44NGQwZGZlNzVhNGFjIDEw
MDY0NA0KPj4gLS0tIGEva2VybmVsL2F1ZGl0c2MuYw0KPj4gKysrIGIva2VybmVsL2F1ZGl0c2Mu
Yw0KPj4gQEAgLTgyMiw2ICs4MjIsNyBAQCBzdGF0aWMgaW50IGF1ZGl0X2luX21hc2soY29uc3Qg
c3RydWN0IGF1ZGl0X2tydWxlICpydWxlLCB1bnNpZ25lZCBsb25nIHZhbCkNCj4+ICAqIHBhcmFt
ZXRlciBjYW4gYmUgTlVMTCwgYnV0IGFsbCBvdGhlcnMgbXVzdCBiZSBzcGVjaWZpZWQuDQo+PiAg
KiBSZXR1cm5zIDEvdHJ1ZSBpZiB0aGUgZmlsdGVyIGZpbmRzIGEgbWF0Y2gsIDAvZmFsc2UgaWYg
bm9uZSBhcmUgZm91bmQuDQo+PiAgKi8NCj4+ICsjcHJhZ21hIEdDQyBvcHRpbWl6ZSgidW5zd2l0
Y2gtbG9vcHMiLCAiYWxpZ24tbG9vcHM9MTYiLCAiYWxpZ24tanVtcHM9MTYiKQ0KPiANCj4gVGhl
IGtlcm5lbCBkb2Vzbid0IHJlYWxseSBtYWtlIHVzZSBvZiAjcHJhZ21hIG9wdGltaXphdGlvbiBz
dGF0ZW1lbnRzDQo+IGxpa2UgdGhpcywgYXQgbGVhc3Qgbm90IGluIGFueSBvZiB0aGUgY29yZSBh
cmVhcywgYW5kIEknbSBub3QNCj4gaW50ZXJlc3RlZCBpbiBiZWluZyB0aGUgZmlyc3QgdG8gZG8g
c28uICBJIGFwcHJlY2lhdGUgdGhlIHRpbWUgYW5kDQo+IGVmZm9ydCB0aGF0IHlvdSBoYXZlIHNw
ZW50IHByb2ZpbGluZyB0aGUgYXVkaXQgc3Vic3lzdGVtLCBidXQgdGhpcw0KPiBpc24ndCBhIHBh
dGNoIEkgY2FuIGFjY2VwdCBhdCB0aGlzIHBvaW50IGluIHRpbWUsIEknbSBzb3JyeS4NCg0KRmFp
ciBlbm91Z2guIFdpbGwgYSBmdW5jdGlvbiBhdHRyaWJ1dGUgYWthOg0KDQpfX2F0dHJpYnV0ZV9f
KChvcHRpbWl6ZSgiZm9vPWJhciIpKSkNCg0KYmUgYWNjZXB0YWJsZSBmb3IgeW91Pw0KDQoNClRo
eHMsIEjDpWtvbg0KDQo+IA0KPj4gc3RhdGljIGludCBfX2F1ZGl0X2ZpbHRlcl9vcChzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRzaywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGF1
ZGl0X2NvbnRleHQgKmN0eCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGxp
c3RfaGVhZCAqbGlzdCwNCj4+IEBAIC04NDEsNiArODQyLDcgQEAgc3RhdGljIGludCBfX2F1ZGl0
X2ZpbHRlcl9vcChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywNCj4+ICAgICAgICB9DQo+PiAgICAg
ICAgcmV0dXJuIDA7DQo+PiB9DQo+PiArI3ByYWdtYSBHQ0MgcmVzZXRfb3B0aW9ucw0KPj4gDQo+
PiAvKioNCj4+ICAqIGF1ZGl0X2ZpbHRlcl91cmluZyAtIGFwcGx5IGZpbHRlcnMgdG8gYW4gaW9f
dXJpbmcgb3BlcmF0aW9uDQo+PiAtLQ0KPj4gMi4zOS4zDQo+IA0KPiAtLSANCj4gcGF1bC1tb29y
ZS5jb20NCj4gDQoNCg==
