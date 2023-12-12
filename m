Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMDsp6Iy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="avpOoBXl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D857AB
	for <audit@vger.kernel.org>; Tue, 12 Dec 2023 02:39:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7i7X1008303;
	Tue, 12 Dec 2023 10:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kr5SEgGEcuq7ozdrvmTuKJvkI3ZDROWug+9PasAoeG0=;
 b=mMDsp6IykdlcGYwAKVx+vjrWM3O1Ex7EtGHaq6ap2dmLY5cOvXTCTX1Vy70fl7O/KomU
 E0qGclbT2900j5fvhruPlFIvqcCzP8eHuu6MmFxH4CrDn52nE6OJBjtYQteCFuL5Lojt
 55KCr2r0ljOE8JfSpbbkCKXHS3d+T2O4wTHPiFVaxo3bfUZt66rnXK+9Q4uMZQRQ9D1r
 lpMn9QNndkp1RGguh2v6FKutaWBlfvwYhEYcjXbRHCqOxnHVediMVoS8AA6/CSew6WFT
 bb10QG2tBkJpFJd7gOV3p49ONdOV+ljFaGhRloeQSoRg+LdIkKm5RXi7Ku8dX3XvXAt9 BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c59wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:39:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC930Fs018654;
	Tue, 12 Dec 2023 10:39:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6c654-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REiqbJ1jOWTVD7fAHiAfg2gWetR0Gynx4AJVTQGe8dGMhWi8I3ASaWtOKwb87xT0XX2yBKMjtNi/h0VcRkDmWF/BJ9tLITfzJPwmZGELm6Z4sl/bXuIkRpZX3mGlGLHjb7fG/sKBsCzT2ubQlZUXGFXvCBCb8z0HSps7Fjeaki8fksDO7XQCWniVdKW+uIrvbGiuHWIAHuX/9bgnbtDtqQaRhzYTL3h4TQYAzQfR7vBBs3hXM1rNscxWTrnEpwhxQyyoz/gadNdDrVnVb3WxVk+4uAPRma5QhqdtI1RASFEkajs1+B3SqdJ1fscciWQJ/xyW8c88umKUZRVBIVKwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr5SEgGEcuq7ozdrvmTuKJvkI3ZDROWug+9PasAoeG0=;
 b=TiQHwrxLAA7MCEk4oDu0pOAHtOh+l28fHRbXvlei4Mc4NZ3myaf95mbl0CTAwm/hQR2p1MtEgNleItEPI8Wr2g3rN2p1cNgvyzsPiOpQdEbwOUAscxnpGlIga0e4gQPP3fJUWdyfFYkwZg6qmfqyLNRYx8mjDqjCqXvwK7KjME4kv8FAey3QADFyGUqdoSwIlI/6zmusD+le51vFmXAhQ4gcE0tu/Lw5CvDwpQi7ZvHh2LmI1jybyTl/ydM6Bi8T87sby2J4TPFI/tTkUTqxWON/Ns8SwjGj/f0WgOarQMtTG1yk15aumpwPuLf1WIDzBaKL2cw60xT/ygRIpTKg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr5SEgGEcuq7ozdrvmTuKJvkI3ZDROWug+9PasAoeG0=;
 b=avpOoBXlQGv1wncvzzICgi6qQhI5PWWuV8JEYmg75pXwbI8lO/d6Fx039wsP4Vso2RTwoJyrlfIjW86/1eAHSiUJ6i+jNGjBDZ2r/1szs08FA9MURn4+cifFpuPwI/yU8GaIwh1HdD2zV/WlBCXtIP4HR5F17cTe6iJkRUG36pM=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 10:39:28 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 10:39:28 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Haakon Bugge <haakon.bugge@oracle.com>
CC: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        Ankur Arora
	<ankur.a.arora@oracle.com>
Subject: Re: [PATCH 2/2] audit: Apply special optimizations
Thread-Topic: [PATCH 2/2] audit: Apply special optimizations
Thread-Index: AQHaLOd7+6LHQG5eRE6VH3I9GvIVZQ==
Date: Tue, 12 Dec 2023 10:39:28 +0000
Message-ID: <9CB090E7-F00D-4EA0-B44E-E9393D3D4402@oracle.com>
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-4-haakon.bugge@oracle.com>
In-Reply-To: <20231212102857.803984-4-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|BN0PR10MB4920:EE_
x-ms-office365-filtering-correlation-id: 9ca98d96-25dc-4f79-b1ec-08dbfafe9e08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 so2/YTAAgnSNx88gXURo2msTD6p+ekR/moIPEfL0JGqmwJdTkt19sUaaCR0p062UDXD6Fv+e5UMUzWkyynnhNutdmyd7rO0Z+ssdHWke3g6yTgJcv2udVvkyqI3VcYtWGUtxRbkQD1CJAunkLkJhyyA02S50D4nEsPb/x8MQq2y635VMA9lo21fBupms8MpEYWki9o9t5kvU4kKpQw0uxiua5H0x9410rhHf/d31Ak/UMKfJbHyuUQuJT8/3LpmdEwaeCp1r3EadsRgsqfsWoDG4NPbQ2+H9zspXToEMwfRyLKxQLD2IbocTbw8SSPkvnImHf2UhaEHUPXnMedG2uD6IpKJUCgByRX+YPv2s7lkCuBt7k2sbAcSb5zCU13B9CYTiL4QxXJVn/jrBkG4A4kjUYXjgrUDxxEDET081NGxEuXnleTuQMGibh23yBqNwI8rw8OEB2lBDGQF6RKn+6DA7F9o4s66o2NH/P/K19SR31y0z+v0PY/MxzuPXJMCAxaTFxd7zwldku/FESVO65ofYiLyLrad2XQqC7tfIzYxWN2aP/nV+t60cTSLGkuxW2Zd1Er7pFhNWGYARVLQV4gqlwLX7/ZuUyEd8DN7UgZ40HRHBv9QK6Q0/5I2bwo16FOvIYqz/qnjwyM4/HTjQbA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(2906002)(6200100001)(37006003)(38070700009)(8676002)(8936002)(316002)(5660300002)(44832011)(4326008)(6862004)(53546011)(107886003)(6512007)(71200400001)(6486002)(6506007)(2616005)(478600001)(86362001)(36756003)(54906003)(33656002)(66946007)(64756008)(91956017)(66556008)(66476007)(66446008)(122000001)(38100700002)(76116006)(83380400001)(66574015)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ckVhUXNobXpHVTZrNHdWVGhEdHFyb3M4bWhHY0dBdzQ3cHQ3bTAwZWZIV3kv?=
 =?utf-8?B?SndYUHQ2M08wajlTV3lTVmVIMC9YSUE4TEF1Y1JmWWpwYzNLZUVpdVJhVDBk?=
 =?utf-8?B?dnZhRFFoTm85N01EUDV4T3N0ckhSWEhmV3cxUnBURjEyUmNXcmpaZnVJYjlO?=
 =?utf-8?B?b2FMdFp0a095QVVNN2JFdDAyVUhNVmVjcTVTcldGNW45c3FBekVNbTZ0ZTZU?=
 =?utf-8?B?cUQvVGZ6TkdqRHVVbWZudVJlT0hWYk84MGxhQmVaSTFLQk5UNVlqaHBXb2hl?=
 =?utf-8?B?enNSNEVnY25VZ2pqWU5SUVdKRDUwaHhaUEtMNkExdXZqWC84eHdseFFBVkRk?=
 =?utf-8?B?V1RBVFJ5dmdQQXZXMnZJSy9VWnF6RmdpODFsTThLWjhxbk9xYmwvd0RRUStQ?=
 =?utf-8?B?OFRNaU9EQUhXWmUvejdEZ2hsdmtoM3hSTmxxZlkyQzFnRXlLVlVrYmxwaGw5?=
 =?utf-8?B?amZtNlhTOVJoM04zai9RRDU5UkR4RUhJTHRXaXdNRndtUjFBMlBudHZ5ak4v?=
 =?utf-8?B?eFU0TWl3NUFRbExvZEo2UHMwL1VZT0Vld29jVmpsUE5CNjZ5L1FheCtiVjdu?=
 =?utf-8?B?VGpwK3FEQTZteWNqcmFvM3JiZVU2SFZVQlkrTXhFb0dMa2NndE1Lb3lKTUYr?=
 =?utf-8?B?bXFaczQzRWFHWXZFUTY5YzdpZkNrSThZOVRlSTdDVWdFK0ZURHc2czIxYnJw?=
 =?utf-8?B?UWNBUitlMEx0TFhHUUJRWk1sWmZleG50bjFOcm42VXF1SXFkbmgzL1NuTE82?=
 =?utf-8?B?OVVMNnpzVURwdG0vZ0VTWTBNRHNwUFN0NzFyQ1RFSmRMNFl1cG1aRjE4cHA2?=
 =?utf-8?B?MjJJcUhrbGFlOVdBbURxeS8rWWV1V1NkSm1uZko2NDV1Tmd5UW9IcWFvSUJz?=
 =?utf-8?B?aXltOTRPTk9Sa0xEM1RvVm9OWWZXV3ZVUWMxaFFHdFdPakl6ckcwSGl3LzA1?=
 =?utf-8?B?VzR2VER1eE56Q1IrUDR3aE9VcUN6Ui9HNExDVzdicjJBY3p4WEVaem9KbkRz?=
 =?utf-8?B?ZzJDVmtvYmRTaGNoeGw0SlhPbjFrMjlUK2NVTFJrR3B4Um9kalhJYVlBdUVo?=
 =?utf-8?B?RXJyeTdKNnhGTWFJNWJZWHhudW1oMlJDcUdySURnVXh0bDVrMkxUQ0RCUFFX?=
 =?utf-8?B?d2tHVTdLQjQ4TDFqT2t1VjVGaGtMK2tUS3NyQm9SOHgyVFIrRVNaaldlbW1V?=
 =?utf-8?B?QnFPNDVCQnZ5RzhQejhZckNneW0xY25YRlhXdm5OWnFqMlhmVU5NVUI2STAw?=
 =?utf-8?B?blNrZFNicGNQbzR3WHdmbVR0dGlQU0IzV3hNMG90RFNGREk2NUJIQnFaOWJV?=
 =?utf-8?B?bnpXb1dUVE1rYVBDVEpWYkxRWnpzSithTE1STk94YVBMczZSc1M3N3dvRWhs?=
 =?utf-8?B?OFFMendJQzUxWlBHS1hZaUFWM0RRS1R4dzk3K0k4dVp4cXMzM0ozbUhDUjU5?=
 =?utf-8?B?ejZHeDlWd3Q2cGRxcWdKUkFHUlNwYVpCWG41aTBrVGhSWlN2a1B1eHNNQ1dK?=
 =?utf-8?B?WU9PMWIrV0JWMWZnVlljS3JlYXRCVXlwSEl5NWV2Zjh4RFBKU3lBd3dsRzZC?=
 =?utf-8?B?QlNzMGQ0Y0xmdkxsNVVWMDVrQUlMUFNDNDJMT3hrMUx1RzQ2a0FObmt5UXpY?=
 =?utf-8?B?UmRNVUpTcmpwbzdaVlQ0ekJLemVKUG01SmptY1dIWThLUXV0YjNRNFByOS9D?=
 =?utf-8?B?K1QzZWUraGZXNjdzc2JiMFBObGxhTTM3M3AzVVliNnNoYk9FYmd1ZDVxT04y?=
 =?utf-8?B?NFM2L2JIaE1nV3hRMTVsbDJicUZpTjVZcFk5aUV1aEMza3p4R1dwYkp4R1lI?=
 =?utf-8?B?Um0rUHdOOG9tNmFUL3RrWDlDTmgxbW5OV0k1M2hrRlBzQTFpQW9pOUFkV0pz?=
 =?utf-8?B?bE0xVnYyVjAwV1E0cUZMSE5mQ080T0VaMWxFbWdTeHRXOWVGcVNXbEtlWGZT?=
 =?utf-8?B?dk96c3FXYTRGc2s0Nkx2MXhHRTZwSDFaWGw3NkZDbXJKQ3FoYVdzckxaK2xi?=
 =?utf-8?B?QzczTzBUZENVRHUxTlVzeGNnWkh2d2FhWGdWeWZDdkJUTnNWbDk3OXZJMTVy?=
 =?utf-8?B?WUZaNEl3TzUrb1Mzck9Ha3BZV2grZFA1MGtEKzN0YjF6YjkxV2R1U1kvYUFN?=
 =?utf-8?B?cVd2dVFKWk5Gbm9sWHlGNW8xSDljSldIUERTTStKTjRWUVZYM0ltWlIzck9B?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABD1B86C47D05F4A8402AED4B8D36A5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fu/qADSB71Ko5SSoprltWMnihXPUOa7GCJDRvF9FGFGiY5KpbZPqtLyVr07D+Afjs4srrsfRcxKHmfXqBBFVOF2d4KQ/SY/GyWlWE4PQrl1Kb9+c2rlLp9ngg94b8EujPEgMkw2TpN8BT/mtXwjrhs4ypadOHnjhmQodMe29VnG73MRSh9lZqDG6txlKQBUiUOBk8Xq6kW99AMo8qqCHlmyTp6QheaPVY3/LTGOI98yo5zbLLvHtguP8Soo0rFwuhx0/W0Ti8JzR6npg8wTRb+EAkgaXTwUU3tNXDtJzrxaZD/lbYCMXsG4La+wSTny8qbOcnpRePjn+1akobZmP2RlKV8DAh6xbEzrWLmQ4BrAZ1DDkPJpxLlcDbISpKbXCzv+FZhJu+sC5UcaqskeqtHuRx/O7I5Aw6G5eC3nPyK66HkoTyVd5QWP5v/BlU5HU9L+3UPCKwbqAJfVAD4TDAd4Od6EqkZonoFtjHL8Y5X3jDP34eG9cRugniY/6rRs5qZ+Sq61an9/sdAkxHsnMwGbo9Um7lgkCDzwJGBciFDGKpfAwZwHbBRUSHXWlQh7iWorV9Hg7TtMSJR5lSrrTUbt3yJPCSMz6jeLA8e5Cu9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca98d96-25dc-4f79-b1ec-08dbfafe9e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 10:39:28.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujqTZ8mV+7BBMfafXONIWQp5nanS8AON0pentqryjGrmxCx56/Mt/XQhHZ/zkBLyDKcSBFfTwiEYGC8CVkRj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120085
X-Proofpoint-ORIG-GUID: rgWWBc_FKsEjtdy2wsfUp7TpQaJhZZmO
X-Proofpoint-GUID: rgWWBc_FKsEjtdy2wsfUp7TpQaJhZZmO

DQoNCj4gT24gMTIgRGVjIDIwMjMsIGF0IDExOjI4LCBIw6Vrb24gQnVnZ2UgPEhhYWtvbi5CdWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IEZvciB0aGUgbW9zdCB0aW1lLWNvbnN1bWluZyBm
dW5jdGlvbiwgd2hlbiBydW5uaW5nIGEgc3lzY2FsbCBiZW5jaG1hcmsNCj4gd2l0aCBTVElHIGNv
bXBsaWFudCBhdWRpdCBydWxlczoNCj4gDQo+ICBPdmVyaGVhZCAgQ29tbWFuZCAgICAgICBTaGFy
ZWQgT2JqZWN0ICAgICAgU3ltYm9sDQo+IC4uLi4uLi4uLiAgLi4uLi4uLi4uLi4uICAuLi4uLi4u
Li4uLi4uLi4uLiAgLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQo+IA0KPiAgICAyNy42MiUgIHN5
c2NhbGxfbGF0ICAgW2tlcm5lbC5rYWxsc3ltc10gIFtrXSBfX2F1ZGl0X2ZpbHRlcl9vcA0KPiAN
Cj4gd2UgYXBwbHkgc3BlY2lhbCBvcHRpbWl6YXRpb25zLCB3aGljaCBzcGVlZHMgdXAgdGhlIHN5
c2NhbGwNCj4gcGVyZm9ybWFuY2UgYnkgYXJvdW5kIDE3JSBvbiBhbiBJbnRlbCBDYXNjYWRlIExh
a2Ugc3lzdGVtLg0KPiANCj4gV2UgcnVuICJwZXJmIHN0YXQgLWQgLXIgNSAuL3N5c2NhbGxfbGF0
Iiwgd2hlcmUgc3lzY2FsbF9sYXQgaXMgYSBDDQo+IGFwcGxpY2F0aW9uIHRoYXQgbWVhc3VyZXMg
YXZlcmFnZSBzeXNjYWxsIGxhdGVuY3kgZnJvbSBnZXRwaWQoKQ0KPiBydW5uaW5nIDEwMCBtaWxs
aW9uIHJvdW5kcy4NCj4gDQo+IEJldHdlZW4gZWFjaCBwZXJmIHJ1biwgd2UgcmVib290IHRoZSBz
eXN0ZW0gYW5kIHdhaXRzIHVudGlsIHRoZSBsYXN0DQo+IG1pbnV0ZSBsb2FkIGlzIGxlc3MgdGhh
biAxLjAuDQo+IA0KPiBXZSBib290IHRoZSBrZXJuZWwsIHY2LjYtcmM0LCB3aXRoICJtaXRpZ2F0
aW9ucz1vZmYiLCBpbiBvcmRlciB0bw0KPiBhbXBsaWZ5IHRoZSBjaGFuZ2VzIGluIHRoZSBhdWRp
dCBzeXN0ZW0uDQo+IA0KPiBMZXQgdGhlIGJhc2Uga2VybmVsIGJlIHY2LjYtcmM0IHdpdGggYm9v
dGVkIHdpdGggImF1ZGl0PTEiIGFuZA0KPiAibWl0aWdhdGlvbnM9b2ZmIiBhbmQgd2l0aCB0aGUg
Y29tbWl0ICJhdWRpdDogVmFyeSBzdHJ1Y3QgYXVkaXRfZW50cnkNCj4gYWxpZ25tZW50IiBvbiBh
biBJbnRlbCBDYXNjYWRlIExha2Ugc3lzdGVtLiBUaGUgZm9sbG93aW5nIHRocmVlDQo+IG1ldHJp
Y3MgYXJlIHJlcG9ydGVkLCBuYW5vc2Vjb25kcyBwZXIgc3lzY2FsbCwgTDFEIG1pc3NlcyBwZXIg
c3lzY2FsbCwNCj4gYW5kIGZpbmFsbHkgSW50cnVjdGlvbnMgUGVyIEN5Y2xlLCBpcGMuDQo+IA0K
PiBCYXNlIHZzLiBiYXNlICsgdGhpcyBjb21taXQgZ2l2ZXM6DQo+IA0KPiBucyBwZXIgY2FsbDoN
Cj4gIG1pbiBhdmcgbWF4ICAgcHN0ZGV2DQo+IC0gMjAzIDIwMyAyMDkgMC45NTQxNDkNCj4gKyAx
NzMgMTczIDE3OCAwLjg4NDUzNA0KPiANCj4gTDFkIG1pc3NlcyBwZXIgc3lzY2FsbDoNCj4gICAg
IG1pbiAgICBhdmcgICAgbWF4ICAgcHN0ZGV2DQo+IC0gIDAuMDEyICAwLjEwMyAgMC44MTcgMC4y
MzgzNTINCj4gKyAgMC4wMTAgIDAuMjA5ICAxLjIzNSAwLjM5OTQxNg0KPiANCj4gaXBjOg0KPiAg
ICBtaW4gICAgYXZnICAgIG1heCAgIHBzdGRldg0KPiAtIDIuMzIwICAyLjMyOSAgMi4zMzAgMC4w
MDMwMDANCj4gKyAyLjQzMCAgMi40MzYgIDIuNDQwIDAuMDA0ODk5DQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQpQbGVhc2UgZGlz
cmVnYXJkIHRoaXMgbWVzc2FnZS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiAtLS0NCj4ga2VybmVs
L2F1ZGl0c2MuYyB8IDIgKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9hdWRpdHNjLmMgYi9rZXJuZWwvYXVkaXRzYy5jDQo+IGlu
ZGV4IDZmMGQ2ZmI2NTIzZmEuLjg0ZDBkZmU3NWE0YWMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9h
dWRpdHNjLmMNCj4gKysrIGIva2VybmVsL2F1ZGl0c2MuYw0KPiBAQCAtODIyLDYgKzgyMiw3IEBA
IHN0YXRpYyBpbnQgYXVkaXRfaW5fbWFzayhjb25zdCBzdHJ1Y3QgYXVkaXRfa3J1bGUgKnJ1bGUs
IHVuc2lnbmVkIGxvbmcgdmFsKQ0KPiAgKiBwYXJhbWV0ZXIgY2FuIGJlIE5VTEwsIGJ1dCBhbGwg
b3RoZXJzIG11c3QgYmUgc3BlY2lmaWVkLg0KPiAgKiBSZXR1cm5zIDEvdHJ1ZSBpZiB0aGUgZmls
dGVyIGZpbmRzIGEgbWF0Y2gsIDAvZmFsc2UgaWYgbm9uZSBhcmUgZm91bmQuDQo+ICAqLw0KPiAr
I3ByYWdtYSBHQ0Mgb3B0aW1pemUoInVuc3dpdGNoLWxvb3BzIiwgImFsaWduLWxvb3BzPTE2Iiwg
ImFsaWduLWp1bXBzPTE2IikNCj4gc3RhdGljIGludCBfX2F1ZGl0X2ZpbHRlcl9vcChzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRzaywNCj4gICBzdHJ1Y3QgYXVkaXRfY29udGV4dCAqY3R4LA0KPiAgIHN0
cnVjdCBsaXN0X2hlYWQgKmxpc3QsDQo+IEBAIC04NDEsNiArODQyLDcgQEAgc3RhdGljIGludCBf
X2F1ZGl0X2ZpbHRlcl9vcChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywNCj4gfQ0KPiByZXR1cm4g
MDsNCj4gfQ0KPiArI3ByYWdtYSBHQ0MgcmVzZXRfb3B0aW9ucw0KPiANCj4gLyoqDQo+ICAqIGF1
ZGl0X2ZpbHRlcl91cmluZyAtIGFwcGx5IGZpbHRlcnMgdG8gYW4gaW9fdXJpbmcgb3BlcmF0aW9u
DQo+IC0tIA0KPiAyLjM5LjMNCj4gDQo+IA0KDQo=
