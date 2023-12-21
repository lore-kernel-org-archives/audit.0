Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABD65195
	for <audit@vger.kernel.org>; Thu, 21 Dec 2023 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3yIYlzB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yMIPVj9p"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLIHOXI022929;
	Thu, 21 Dec 2023 19:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SScmVVTwmY3sKj9TF2o7XhMliFTfLOegkfwFL+gYAlU=;
 b=F3yIYlzBqQNMc8jvO3hswsW1IwB1rM4+4ZTPHyimShSw7kIW6L1RCBvqlcBghpC40wb6
 KIhcibe2GXEDNMOTq2gTXQeueW7Q35UTdViwl3PP2MW9fXg+OnITiNxQgjtNbHyKyBMu
 BT4NwBr/+UiPu2t/YiwpPs4gc9ThFJypCSN5IoC5j3gKRLjX3jVX67p9hdM6TQjWeL+5
 GrxLrr29GA9AxePhz5E8Z9H3384TP6FmjeDovNwZoKHIkSqGaeZHNMQYZinPUceIE/8i
 USzv0RYw1H/WRQ8QjXA+/nRbTfycylvE6GKqKVuonWWCo8pZwCdsF04Ji1aBv4giLuHG SA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4c01p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 19:05:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLHbXF1031178;
	Thu, 21 Dec 2023 19:05:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bhnbm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 19:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIASIRhaHQJHzoKuNEji46SG9tSeEmrcIMky39p2iATfgDSi72F9EEyqS+pV/dSQZhxdOS+wIDiWpfldFlFwAUpDpVB3TCpVF8lmZMzqXTPhVPSxHTWuVTKHqzMdzUuzlIQDAxKmODtwwMkcNXy/bbiUuuHVqFzpOlKGrVomlGXn4qQz3SNmQW+/xdTuMKY/3fCu8mZJ94FvuImqamfo7zJTdFE5u3tVJXegTexF6Yr1zVtFHGMK3o0XlBYxwCJtIsQBKt5Onf1KDaGI8w3kpoDwc84oLktIUbqZw8UE2D/Tlh8o76s7GihSp13PyQZt3j7CF4FJs8hI1PJecE7l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SScmVVTwmY3sKj9TF2o7XhMliFTfLOegkfwFL+gYAlU=;
 b=GdG02eCl8nC9RglG/PrIo+JOwi5dZIrWjr+DoVlPLeqciguhhKtxJ4U5IQRW0TcW4+LWup/nm0hIRsee+gcX8xdJ/jx20C4EwFJvOTtu782PyMIkb6RhasZU+pfGnWSkoHWpZySSNXQVT25wQFhoqv8UZVMizrKpdlU72JWLSs1JW8cKIJjP3K0FnInw+Q4rPtmzAsxjvSV690JNX3tuo3JkMLgnM6RhUe+iVohH2paMW5H/81AxXzsIhoJTkrFueEcZu4QwAy+7TeKR7Z8EvEYrLlEymLVRZ1pyTgRArYTKTC+JKOOYyIBowP/V0IMsoRfLoMnhSzQysUCMYMiYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SScmVVTwmY3sKj9TF2o7XhMliFTfLOegkfwFL+gYAlU=;
 b=yMIPVj9pMmoZtFiLH4dl51OtNjVnqa0HwcUlkoRuoZevf7EYu5NKIsevZmG8T4lMLUe3HeNxQq8Gqdl5gRX7nrMT8jHrzNsU9+0RhznR0woMs7XDeCCWANLtYyJIUfY6BfuKz0pxeXuM1x+1sdP3W5yb8IuqSPaeYJ/A2hD0MB4=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by IA0PR10MB6770.namprd10.prod.outlook.com (2603:10b6:208:43d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 19:05:18 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 19:05:18 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Eric Paris <eparis@redhat.com>,
        "audit@vger.kernel.org"
	<audit@vger.kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 2/2] audit: Apply codegen optimizations
Thread-Topic: [PATCH 2/2] audit: Apply codegen optimizations
Thread-Index: AQHaLh58sc5YvNqF2kWi0fPrhBBXabCsHXAAgAOD8gCABIOagA==
Date: Thu, 21 Dec 2023 19:05:18 +0000
Message-ID: <D2FCA0C0-72EE-4A6A-BE25-1DEC368C1797@oracle.com>
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-3-haakon.bugge@oracle.com>
 <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
 <CEB5B23B-7D1D-4C7B-B8A6-CA07239CB5EF@oracle.com>
 <CAHC9VhRR+WuY6ZG7G6_qFipZyydtFUkju+ZjXyfpKwo_C7CCPg@mail.gmail.com>
In-Reply-To: 
 <CAHC9VhRR+WuY6ZG7G6_qFipZyydtFUkju+ZjXyfpKwo_C7CCPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|IA0PR10MB6770:EE_
x-ms-office365-filtering-correlation-id: 1787c659-f11a-4db2-9787-08dc0257c5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Tbu/FLHMhWwrK1BGjOQade15Gag0w1bJgK/0Gg+tMZlwkbNltU+BTIZVkNmPTmZeUQV/E7fb3XiG7S/wHS0wj2zkcO+9YHGHbTRWtCPXzo/EuF85cVVJJRW3hQz+49aNJCv7eESb4vh+UZcq3UVGojCl174VlzMfvH55vhvcP8/jnIgL9OMwXZNByzTNLrkEsSI9/x0ffWJhVJBa4Yu5g1gcQqxHhtpoQiIqvwZEycqooY/38VcSdyCGmSG5LpqfggxHk4myrEmXEs76X91PMJ9/RisvoLDX44byy0T8y+ww0B6qPQCF2tfifKi9vOVLeQ152/I5Hs8Dry3aVRSSrDGuIK3NjfWXZNWWUo7w+epIq0yFNsCOTNhbVwGuCuxPD5NJKDJLtilMvddZf5gyCp4c2yAD4y2wMnSNkakRlaXj+ErdTXM/RJKP6P5x1SJb9N8wzb1An/SoYrAvHoir6IAEetzO+jBD0q5WH7+W42CgydQtAlP6uRMAGcmfblHjSa2pcoDwQmus+dHTMHfil8ahNevisBx4kuoYcu6ffbWvBjCwL4bYKnXAB+4ecNYQUhMtHfReualYO6zRuaFQcnVSiS0PVvhOYyNL8CLQsx7Je5ZPJ7UihfNYrDLUred7VP/D7j3lL1vczOUJVZ0NNQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(71200400001)(478600001)(38100700002)(122000001)(66574015)(26005)(83380400001)(107886003)(2616005)(53546011)(6512007)(6506007)(33656002)(8936002)(4326008)(2906002)(36756003)(41300700001)(5660300002)(8676002)(44832011)(86362001)(6916009)(38070700009)(66946007)(76116006)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YTRLbGV1MTVxb01haUdBRzlGY01QdThNWExuYjdtVlFMWWd3YWlLZUtqMVhY?=
 =?utf-8?B?VEdnRVQxbEU0WHZZVVZkQXJ2MFdGdVUxWTZySy9ZWHdVeURXbTZZZnUrRGJD?=
 =?utf-8?B?Tm9mb1VmdkpLRzdBWUFjRXBjM2tUeVZuWXpJRXBpOXYxZkhXTjlKbHZmOXBs?=
 =?utf-8?B?dmtVbFJIZnJHaU0zZXIzbktObVRXckpXRnNjeXhScXdOZVlScWZqUG1SOHV3?=
 =?utf-8?B?RHdHTlR1N2JCYXRGMkFlSFdjNnNWUkZmeGp3Z2R4TkoxNVlPMmtVeEJaM2xW?=
 =?utf-8?B?NlAvNzQ5dHZ2TzM5NE1mVDBDbUhxSjlLUjJJZjdjYmhmUW9xV0NTVjN6Ykg1?=
 =?utf-8?B?L2RTSXd6bFdpUXpSeGFoZjhMRlhmc1VIdWNZcEZvU0dYZjByRmdPeENUcTBq?=
 =?utf-8?B?UVMwOXZzRTVobnBxVStDUG5ML213bjhqTXZiTGRFVktkbUQwVjh4Sy9jc0tZ?=
 =?utf-8?B?V0tQemFrSS9BcGh3SE0rOGhScEQwU0t4R3JhMU1pVHFvS21PR3N3enZJZ1JQ?=
 =?utf-8?B?QmI0UVRNMCt2OFBkMDNad1RtVTNzZ3orMU5ma0hJVkdOZ1hRaXFzT0RzT2hx?=
 =?utf-8?B?OStsU0IvSEhKWnJKWi9hR3pNcHk2NnhTMlpBNHd1SVpoamh2S2FpdFJhbG8z?=
 =?utf-8?B?a2FnakhxNXZ3LzVoZE5PQ2dySG55STJTRmVmYzZ1L01Rc1FsTnRvdVpXZzNU?=
 =?utf-8?B?dUtyQ0NVRGhpUGRUbHZJeVNKVTRqa1IzdUFEZC84TnQ4bzdNdUprYUp4YXB4?=
 =?utf-8?B?dG56ZzdObzZQT2tNQzRWVy9RU3YzMDBoanpnOHdLcXgvTFRObkZES2tERXUr?=
 =?utf-8?B?eGY4VVNsWFhtYmg3MDltcDdZcjM3bVZTejc0Yld5cXl3YlJuUzJ0Z1N6bXkw?=
 =?utf-8?B?dHNlRGJyMWJMbG1rbkw5NGdqaGl6Tm9OQk9oTjF6SklKdUY5YUQ5NHlVUis0?=
 =?utf-8?B?MHFsYS9WemQvVndVZFMyUUluRC82cFNBMjZpbENXVi9TT0VQTCtBTC9ESU0w?=
 =?utf-8?B?NmVDdWhpVVJyVnM1WkdLYjB2VWptU2l3YUZFN0x3VXJUUGE2OW40NDF4K3ow?=
 =?utf-8?B?bXBETjVIbWl3Rzd2ejdxZGNNOFlOU3J2Y01MNHlVczlZcHRha01UazB3NDRt?=
 =?utf-8?B?eVBnYVhtMGQvUkZnTk5BRGQ0cWF5NzFaMWFhemVhVWJENWJrbWhiakcrZzJl?=
 =?utf-8?B?MnV0RlQyWHRjSG1XMzNqQVZ3SVNoN041eEJmTFZMTUs2T0xmSUdxbDR2aTBk?=
 =?utf-8?B?R1F1Zlg3bXhtdGIwdWo5QXNrWkpocGtnTXZPOGpyQlFHaWd3TUlXeFVpcXZO?=
 =?utf-8?B?Y21IR3JsMHozQ2I4VEltMmtFcTFNaDVEWDFZOU9aYUxFQU1TcEpBVW9aeFBM?=
 =?utf-8?B?ZzdNMGVmV0JRaHl5bDlTV2l0citOWHNheTNTU2pKUmV3TE5BYzFQcS9wRU1s?=
 =?utf-8?B?T293M1pWVXhoNDhmN0t1ejE2N2hiZDlIT3BndVp5cC82TWZRZDJQNy9OdmtL?=
 =?utf-8?B?MHY1RXdpRDIrdjZIR1ZqNHZnQkRDM09EdWRvS0xiTlEyTVQ1V3pxU3FTYWFI?=
 =?utf-8?B?YlowYjRTN2FkeTJKYk5FRXhVSnVaSmx0bmppK2lPK1NGNXJIdVh6UWprditE?=
 =?utf-8?B?SnI5dHo1TDIxUWxkRXBCL3ZJK04weWIyaVdxcTE0dTZpY1ZFczJ5aG9MaW9v?=
 =?utf-8?B?UTRwS3JHdi9sc0VYSHJ2a0xDU1hYclkyd0NoTGdYcURkMU5yamgvRjBQSmtU?=
 =?utf-8?B?YUhIK1dZaE80NlFHb05scFhWbFp6bFRQN2lseUs5T0xURlhSM05RUTFrbjBw?=
 =?utf-8?B?Tkt0dExnU3drTHlxQjAybmJWbFByNkEwZXFRZE4ybGJSZ1BGS1NnYzA4QlJQ?=
 =?utf-8?B?MFgrTFdlaExPQXByU3FsTXArdDcxVjQwZFFHdDhWa0IyQlNjVzVRUlJxN1dB?=
 =?utf-8?B?OFJwa3FxVTJLaE9yaDNtYnliNVlHSzdlbHhXbjZubXhXWFNwS0JnT29palc4?=
 =?utf-8?B?VytYMVdZSDNOUW4vMFRtb3BKSHBzbmRHbVVieVVSSkFicXVhYXBvNUNFVWZa?=
 =?utf-8?B?amtDSy9iV3Q4L0tnU2NrWTJ3OU9aOTErMmF1d21CT1ZNLytXdjBoaEJLbXE0?=
 =?utf-8?B?djFlTXp3ckNjMFJFRXhGZndSOTgrQVRoZ2hCMENTbGppR2t5YUdTbXdrNnkv?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19E4CB6E966B3445A902A6FF36A5DEEA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pJVlq+b4SUDiCxKhOOPCqwCYdM2Dq1MNrmkpdGCFbr6v0Xwe6yQRPRyrxjfPBXL7BSvtz0PKb976zqy2nsQNPSbfLGEfBZ269AWvbe7lH1KXHCSM/hEn/EyOuh2e4VYhiS78+Ddredwb0fGj4iPq+gAlRIEbjQuihPZ2EvQndgryNSTfByGZH8gay/rMT/TdX7QsK2u5VK2/U8Sbcc0M4HvOax+PlqTf5YsyfAB1xZyR2skkL4vecOYCjwk1WHjXKLEmZWu4svxKLBlVPw2EdanZL6wi730SeT/lVQAUdkSrCuChmraVuav85f04shdbRssX7357TUmsddV0xycJwDXMO3fJNlftIhmtKSUymnvhcRB4V7kbjf7QfRxrzjoEmgvWLsU+SrWTAv9qFZJttf89NgreC830Lw9O6Ob+Wl6IYQlFT0zbC9F2gDow1AYFNoewZ78pEy/AyjlAbE++WjYfhayj9j/GdGZi4q66K2PQc1h53KTwmqQZVeLFAgdLaqkK48BrmkD0jRhAAow/NtUvm+Hap5yf1fq3Y2cWYanpzrCHrTbZ2dJ3yC1WxUDk8/e670bBgHkb5uryc1igFqH2foR56zWryQZsRYNkpy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1787c659-f11a-4db2-9787-08dc0257c5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 19:05:18.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvtnmhNXSio1KUNwE2IlC9s1eGBIeHx/vNXFGE3T/8ASniDsPVl4WWLZC/WxDCG3wxkkKGpTGdjVgqdTPH7i2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_09,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210145
X-Proofpoint-GUID: 7SvTy0rZrBtP2yb9-ruLm1YfGfhd2uF5
X-Proofpoint-ORIG-GUID: 7SvTy0rZrBtP2yb9-ruLm1YfGfhd2uF5

DQoNCj4gT24gMTggRGVjIDIwMjMsIGF0IDIzOjA5LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgRGVjIDE2LCAyMDIzIGF0IDExOjI44oCvQU0g
SGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gT24gMTQg
RGVjIDIwMjMsIGF0IDAwOjQ1LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90
ZToNCj4+PiBPbiBUdWUsIERlYyAxMiwgMjAyMyBhdCA1OjI54oCvQU0gSMOla29uIEJ1Z2dlIDxo
YWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBGb3IgdGhlIG1vc3Qg
dGltZS1jb25zdW1pbmcgZnVuY3Rpb24sIHdoZW4gcnVubmluZyBhIHN5c2NhbGwgYmVuY2htYXJr
DQo+Pj4+IHdpdGggU1RJRyBjb21wbGlhbnQgYXVkaXQgcnVsZXM6DQo+Pj4+IA0KPj4+PiBPdmVy
aGVhZCAgQ29tbWFuZCAgICAgICBTaGFyZWQgT2JqZWN0ICAgICAgU3ltYm9sDQo+Pj4+IC4uLi4u
Li4uLiAgLi4uLi4uLi4uLi4uICAuLi4uLi4uLi4uLi4uLi4uLiAgLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uDQo+Pj4+IA0KPj4+PiAgIDI3LjYyJSAgc3lzY2FsbF9sYXQgICBba2VybmVsLmthbGxz
eW1zXSAgW2tdIF9fYXVkaXRfZmlsdGVyX29wDQo+Pj4+IA0KPj4+PiB3ZSBhcHBseSBjb2RlZ2Vu
IG9wdGltaXphdGlvbnMsIHdoaWNoIHNwZWVkcyB1cCB0aGUgc3lzY2FsbA0KPj4+PiBwZXJmb3Jt
YW5jZSBieSBhcm91bmQgMTclIG9uIGFuIEludGVsIENhc2NhZGUgTGFrZSBzeXN0ZW0uDQo+Pj4+
IA0KPj4+PiBXZSBydW4gInBlcmYgc3RhdCAtZCAtciA1IC4vc3lzY2FsbF9sYXQiLCB3aGVyZSBz
eXNjYWxsX2xhdCBpcyBhIEMNCj4+Pj4gYXBwbGljYXRpb24gdGhhdCBtZWFzdXJlcyBhdmVyYWdl
IHN5c2NhbGwgbGF0ZW5jeSBmcm9tIGdldHBpZCgpDQo+Pj4+IHJ1bm5pbmcgMTAwIG1pbGxpb24g
cm91bmRzLg0KPj4+PiANCj4+Pj4gQmV0d2VlbiBlYWNoIHBlcmYgcnVuLCB3ZSByZWJvb3QgdGhl
IHN5c3RlbSBhbmQgd2FpdHMgdW50aWwgdGhlIGxhc3QNCj4+Pj4gbWludXRlIGxvYWQgaXMgbGVz
cyB0aGFuIDEuMC4NCj4+Pj4gDQo+Pj4+IFdlIGJvb3QgdGhlIGtlcm5lbCwgdjYuNi1yYzQsIHdp
dGggIm1pdGlnYXRpb25zPW9mZiIsIGluIG9yZGVyIHRvDQo+Pj4+IGFtcGxpZnkgdGhlIGNoYW5n
ZXMgaW4gdGhlIGF1ZGl0IHN5c3RlbS4NCj4+Pj4gDQo+Pj4+IExldCB0aGUgYmFzZSBrZXJuZWwg
YmUgdjYuNi1yYzQgd2l0aCBib290ZWQgd2l0aCAiYXVkaXQ9MSIgYW5kDQo+Pj4+ICJtaXRpZ2F0
aW9ucz1vZmYiIGFuZCB3aXRoIHRoZSBjb21taXQgImF1ZGl0OiBWYXJ5IHN0cnVjdCBhdWRpdF9l
bnRyeQ0KPj4+PiBhbGlnbm1lbnQiIG9uIGFuIEludGVsIENhc2NhZGUgTGFrZSBzeXN0ZW0uIFRo
ZSBmb2xsb3dpbmcgdGhyZWUNCj4+Pj4gbWV0cmljcyBhcmUgcmVwb3J0ZWQsIG5hbm9zZWNvbmRz
IHBlciBzeXNjYWxsLCBMMUQgbWlzc2VzIHBlciBzeXNjYWxsLA0KPj4+PiBhbmQgZmluYWxseSBJ
bnRydWN0aW9ucyBQZXIgQ3ljbGUsIGlwYy4NCj4+Pj4gDQo+Pj4+IEJhc2UgdnMuIGJhc2UgKyB0
aGlzIGNvbW1pdCBnaXZlczoNCj4+Pj4gDQo+Pj4+IG5zIHBlciBjYWxsOg0KPj4+PiBtaW4gYXZn
IG1heCAgIHBzdGRldg0KPj4+PiAtIDIwMyAyMDMgMjA5IDAuOTU0MTQ5DQo+Pj4+ICsgMTczIDE3
MyAxNzggMC44ODQ1MzQNCj4+Pj4gDQo+Pj4+IEwxZCBtaXNzZXMgcGVyIHN5c2NhbGw6DQo+Pj4+
ICAgIG1pbiAgICBhdmcgICAgbWF4ICAgcHN0ZGV2DQo+Pj4+IC0gIDAuMDEyICAwLjEwMyAgMC44
MTcgMC4yMzgzNTINCj4+Pj4gKyAgMC4wMTAgIDAuMjA5ICAxLjIzNSAwLjM5OTQxNg0KPj4+PiAN
Cj4+Pj4gaXBjOg0KPj4+PiAgIG1pbiAgICBhdmcgICAgbWF4ICAgcHN0ZGV2DQo+Pj4+IC0gMi4z
MjAgIDIuMzI5ICAyLjMzMCAwLjAwMzAwMA0KPj4+PiArIDIuNDMwICAyLjQzNiAgMi40NDAgMC4w
MDQ4OTkNCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1
Z2dlQG9yYWNsZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBrZXJuZWwvYXVkaXRzYy5jIHwgMiArKw0K
Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4+IA0KPj4+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL2F1ZGl0c2MuYyBiL2tlcm5lbC9hdWRpdHNjLmMNCj4+Pj4gaW5kZXggNmYw
ZDZmYjY1MjNmYS4uODRkMGRmZTc1YTRhYyAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL2F1ZGl0
c2MuYw0KPj4+PiArKysgYi9rZXJuZWwvYXVkaXRzYy5jDQo+Pj4+IEBAIC04MjIsNiArODIyLDcg
QEAgc3RhdGljIGludCBhdWRpdF9pbl9tYXNrKGNvbnN0IHN0cnVjdCBhdWRpdF9rcnVsZSAqcnVs
ZSwgdW5zaWduZWQgbG9uZyB2YWwpDQo+Pj4+ICogcGFyYW1ldGVyIGNhbiBiZSBOVUxMLCBidXQg
YWxsIG90aGVycyBtdXN0IGJlIHNwZWNpZmllZC4NCj4+Pj4gKiBSZXR1cm5zIDEvdHJ1ZSBpZiB0
aGUgZmlsdGVyIGZpbmRzIGEgbWF0Y2gsIDAvZmFsc2UgaWYgbm9uZSBhcmUgZm91bmQuDQo+Pj4+
ICovDQo+Pj4+ICsjcHJhZ21hIEdDQyBvcHRpbWl6ZSgidW5zd2l0Y2gtbG9vcHMiLCAiYWxpZ24t
bG9vcHM9MTYiLCAiYWxpZ24tanVtcHM9MTYiKQ0KPj4+IA0KPj4+IFRoZSBrZXJuZWwgZG9lc24n
dCByZWFsbHkgbWFrZSB1c2Ugb2YgI3ByYWdtYSBvcHRpbWl6YXRpb24gc3RhdGVtZW50cw0KPj4+
IGxpa2UgdGhpcywgYXQgbGVhc3Qgbm90IGluIGFueSBvZiB0aGUgY29yZSBhcmVhcywgYW5kIEkn
bSBub3QNCj4+PiBpbnRlcmVzdGVkIGluIGJlaW5nIHRoZSBmaXJzdCB0byBkbyBzby4gIEkgYXBw
cmVjaWF0ZSB0aGUgdGltZSBhbmQNCj4+PiBlZmZvcnQgdGhhdCB5b3UgaGF2ZSBzcGVudCBwcm9m
aWxpbmcgdGhlIGF1ZGl0IHN1YnN5c3RlbSwgYnV0IHRoaXMNCj4+PiBpc24ndCBhIHBhdGNoIEkg
Y2FuIGFjY2VwdCBhdCB0aGlzIHBvaW50IGluIHRpbWUsIEknbSBzb3JyeS4NCj4+IA0KPj4gRmFp
ciBlbm91Z2guIFdpbGwgYSBmdW5jdGlvbiBhdHRyaWJ1dGUgYWthOg0KPj4gDQo+PiBfX2F0dHJp
YnV0ZV9fKChvcHRpbWl6ZSgiZm9vPWJhciIpKSkNCj4+IA0KPj4gYmUgYWNjZXB0YWJsZSBmb3Ig
eW91Pw0KPiANCj4gVW5sZXNzIHlvdSBjYW4gc2hvdyBtZSB3aWRlc3ByZWFkIGFjY2VwdGFuY2Ug
b2YgdGhlc2UgdHlwZXMgb2YNCj4gb3B0aW1pemF0aW9ucyBpbiBjb3JlIGtlcm5lbCBjb2RlLCBt
eSBhbnN3ZXIgaXMgbm8uICBJJ20gc29ycnkuDQoNCkhpIFBhdWwsDQoNCldlbGwsIEkgZ3Vlc3Mg
d2UgYm90aCBrbm93IHRoYXQgSSBjYW5ub3Qgc2hvdyB5b3UgYW55ICJ3aWRlc3ByZWFkIGFjY2Vw
dGFuY2UiIG9mIHRoZSBzb3J0LiBIZXJlIGlzIHdoYXQgSSBzZWU6DQoNCmFyY2gvYXJtL2xpYi94
b3ItbmVvbi5jOiNwcmFnbWEgR0NDIG9wdGltaXplICJ0cmVlLXZlY3Rvcml6ZSINCihub3Qgd2hh
dCB5b3UgZGVzY3JpYmUgYXMgY29yZSBrZXJuZWwpDQoNCmxpYi96c3RkL2NvbW1vbi9jb21waWxl
ci5oOiMgICAgZGVmaW5lIERPTlRfVkVDVE9SSVpFIF9fYXR0cmlidXRlX18oKG9wdGltaXplKCJu
by10cmVlLXZlY3Rvcml6ZSIpKSkNCihjb3JlLCBidXQgbm90IHdpZGVzcHJlYWQpDQoNClRoZW4g
b2YgY291cnNlLCB0aGVyZSBhcmUgbW9yZSBleGFtcGxlcyBvZiBzcGVjaWZpYyBvcHRpbWl6YXRp
b25zIG9yIGRpc2FibGUgdGhlcmVvZiBpbiBNYWtlZmlsZXM6DQoNCmtlcm5lbC9kZWJ1Zy9rZGIv
TWFrZWZpbGU6Y2xlYW4tZmlsZXMgOj0gZ2VuLWtkYl9jbWRzLmMNCmtlcm5lbC9rY3Nhbi9NYWtl
ZmlsZTpDRkxBR1NfY29yZS5vIDo9ICQoY2FsbCBjYy1vcHRpb24sLWZuby1jb25zZXJ2ZS1zdGFj
aykgXA0Ka2VybmVsL2tjc2FuL01ha2VmaWxlOiAtZm5vLXN0YWNrLXByb3RlY3RvciAtRERJU0FC
TEVfQlJBTkNIX1BST0ZJTElORw0Ka2VybmVsL2tjc2FuL01ha2VmaWxlOkNGTEFHU19rY3Nhbl90
ZXN0Lm8gOj0gJChDRkxBR1NfS0NTQU4pIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyDQprZXJuZWwv
TWFrZWZpbGU6Q0ZMQUdTX2tjb3YubyA6PSAkKGNhbGwgY2Mtb3B0aW9uLCAtZm5vLWNvbnNlcnZl
LXN0YWNrKSAtZm5vLXN0YWNrLXByb3RlY3Rvcg0Ka2VybmVsL01ha2VmaWxlOmNsZWFuLWZpbGVz
IDo9IGtoZWFkZXJzX2RhdGEudGFyLnh6IGtoZWFkZXJzLm1kNQ0Ka2VybmVsL3NjaGVkL01ha2Vm
aWxlOiMgQWNjb3JkaW5nIHRvIEFsYW4gTW9kcmEgPGFsYW5AbGludXhjYXJlLmNvbS5hdT4sIHRo
ZSAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciBpcw0Ka2VybmVsL3NjaGVkL01ha2VmaWxlOkNGTEFH
U19jb3JlLm8gOj0gJChQUk9GSUxJTkcpIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyDQprZXJuZWwv
YnBmL01ha2VmaWxlOmNmbGFncy1ub2djc2UtJChDT05GSUdfWDg2KSQoQ09ORklHX0NDX0lTX0dD
QykgOj0gLWZuby1nY3NlDQprZXJuZWwvZW50cnkvTWFrZWZpbGU6Q0ZMQUdTX1JFTU9WRV9jb21t
b24ubyA9IC1mc3RhY2stcHJvdGVjdG9yIC1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZw0Ka2VybmVs
L2VudHJ5L01ha2VmaWxlOkNGTEFHU19jb21tb24ubyArPSAtZm5vLXN0YWNrLXByb3RlY3Rvcg0K
a2VybmVsL3JjdS9NYWtlZmlsZTpLQlVJTERfQ0ZMQUdTICs9IC1nIC1mbm8tb21pdC1mcmFtZS1w
b2ludGVyDQoNCk15IHZpZXcgaXM6DQoNClRoZSBjb2Rpbmcgb2YgdGltZSBjcml0aWNhbCBmdW5j
dGlvbnMsIHRoYXQgYWNjZXNzIHN0cnVjdHMsIHRoYXQgYXJlIGFsbG9jYXRlZCBieSBre20sen1h
bGxvYyBhbmQgZmFtaWx5LCBpbiBhIHNob3J0IHByb3hpbWl0eSBpbiB0aW1lLCBpcywgd2l0aCBh
bGwgcmVzcGVjdCwgbm90IGEgZ29vZCBwcm9ncmFtbWluZyBwcmFjdGljZSwgYXMgZGVwaWN0ZWQg
YnkgdGhlIGV4YW1wbGUgaW4gdGhpcyBwYXRjaCBzZXJpZXMuDQoNCkkgaGF2ZSB0byBhY2NlcHQs
IHRoYXQgeW91IHdpbGwgbm90IGFjY2VwdCB0aGlzIHBhdGNoIHNlcmllcyBvciBhIHYyIHRoZXJl
b2YuDQoNCkJ1dCwgdGhpcyBsZWF2ZXMgKDIxMCAtIDE3MykgPSAzNyBuYW5vc2Vjb25kIHVubmVj
ZXNzYXJ5IG92ZXJoZWFkIG9mIGEgc3lzY2FsbCBvbiB0aGUgZmxvb3IuDQoNCkl0IHNob3VsZCBi
ZSB1bm5lY2Vzc2FyeSB0byBxdW90ZSB0aGUgbnVtYmVyIG9mIENhc2NhZGUgTGFrZSBzeXN0ZW1z
IGJlaW5nIGRlcGxveWVkLCBob3cgbWFueSBvZiB0aGVtIHRoYXQgcnVuIHdpdGggYXVkaXQgZW5h
YmxlZCBhbmQgU1RJRyBjb21wb25lbnQgcnVsZXMsIHRvIHBvaW50IG9mIHRoZSBzaWduaWZpY2Fu
Y2Ugb2YgdGhvc2UgbmFub3NlY29uZHMuDQoNCkkgd291bGQgYmUgdmVyeSBhcHByZWNpYXRpdmUg
aWYgeW91IGNvdWxkIGNvbWUgdXAgd2l0aCBhIGJldHRlciBhbmQgbW9yZSBhY2NlcHRhYmxlIHNv
bHV0aW9uLCBpbiBvcmRlciB0byBzaGF2ZSBvZmYgdGhlc2UgbmFub3NlY29uZHMuDQoNCg0KVGh4
cywgSMOla29uDQoNCg0KDQo=
