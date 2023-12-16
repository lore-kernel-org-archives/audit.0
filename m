Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB531EB52
	for <audit@vger.kernel.org>; Sat, 16 Dec 2023 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gshwNZLv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A4Lq5AWE"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGDZht0004760;
	Sat, 16 Dec 2023 16:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xmLIKL12p+NbDCwCdIUBwafbDJ4D9dnilOntwZZceZ0=;
 b=gshwNZLvqYEUXiq8uL53DnMnhFKfLjLV2gKrXFYgSXjc0/J9QCYW/JIUa24LluiIPU4/
 a+D0nL50MsDE0Stwh0PyExc2YeEJVtfqoaSgemXtaovKOOGqPVdUPBgkqv663+WAldtU
 pnYDHGTQJdnHC6HUiMc7g5mia3VAvJwAh4Eal9Tq8kcmPIwspUlfw3oHyKxyIZRuGEo+
 Ej1eR9IdoN+rizrrxs2vsd4dl4B7gizsJ9j/9JCizq9zSToOsQsres6cfnKzM/NGbuQH
 7+HFILBzZMLG7JOOny63eAgcIGCX4N3ZSoWCt7UVNK11cpqHFqUYIBUJQH+X6rKXvJgh Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb0mnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:25:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGCgcph029100;
	Sat, 16 Dec 2023 16:25:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b3b6kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS5erEhlfFJ2EYwcxKOMhHYY79fYEwEmN6ttpHjpsXy/60+74+ta6SgRxPP7z30Iz5n/CRDvvVEWmrNiI5Iawvy+Yw5SV9N+brGggeyCdTltbqGcoQszeIjYDOlcrCwPje0XOh3ml1IM/veSy5Xwx6CgRcRpEQNWy1soGNjnbdwsx1ZyPzYD14bgAZ85IY7HPxl99lh66hBPWqQA0KlZ07ddapjMuo9W0SrLoTFDepu7nTugu7/slNKY9MTkjGZC7JMVUjTViY++biR2KaCmk+x72hGQ/pLDQXnFRUsdRtzKaR4beD7sxlXYOiXtY96Y6ZNt+lpg5zoKE5418QPQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmLIKL12p+NbDCwCdIUBwafbDJ4D9dnilOntwZZceZ0=;
 b=MRtxXqxYxeAjJ7TL6lq6wA5hF78b+UfArkba6rByLOGrCWhQm0kOtdAnMvPi7Ej0yIs+zy4R5+bbTi/ClCBBdSYrj57G4VJolxgH07Z/egEa20brRrgMiZUQv+Ya2aHkJPvB1fkWyrnX1Oldel/6+mqVYGjtozlH6UMryud97C9sMxa6iZjy5h0dkiKakB6cqzgkXI4jyjXXbczf3JQQkq2KatEKRkb+2noE/j6wDmcu05L9ws8Drye3/cdcdw2gkTGlmeQA5r6bcv+o2AB9Tk73awLZWoPP+NQEpMwjhBN/k/NjvF7y8RCcuANQn6MZ5PtRKEIVAfgdxRBbJ+nUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmLIKL12p+NbDCwCdIUBwafbDJ4D9dnilOntwZZceZ0=;
 b=A4Lq5AWExxQnlltBc5cXJSorV8sBP4hBOYCU32PGRSRTojCobm7jRY32hNE/cupmgfNvdfAV09GIsblybWsb9WfFSanTOized0r35XWP9D+gecUnD/hyQzOnMYWkhfUSnJPtB0q4gyZuzWIxHWnPysv3VCYOySl528BNsU2he5A=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Sat, 16 Dec
 2023 16:25:28 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b850:7ce8:b7be:c8c0%5]) with mapi id 15.20.7091.034; Sat, 16 Dec 2023
 16:25:28 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Eric Paris <eparis@redhat.com>,
        "audit@vger.kernel.org"
	<audit@vger.kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 1/2] audit: Vary struct audit_entry alignment
Thread-Topic: [PATCH 1/2] audit: Vary struct audit_entry alignment
Thread-Index: AQHaLh/M+3wpt+X4NUGwyHbe4WXK2bCsHKmA
Date: Sat, 16 Dec 2023 16:25:28 +0000
Message-ID: <738EAB12-E8FF-49E9-BD92-4E3630AFDB17@oracle.com>
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-2-haakon.bugge@oracle.com>
 <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
In-Reply-To: 
 <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|PH0PR10MB5896:EE_
x-ms-office365-filtering-correlation-id: 3c8f5064-57ff-4cae-40d2-08dbfe539d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CwwkXXKN8Dtc73gxSeZQkgP/R0XAOLHEgXVHlUnxCM5pTPCXwNpTqvquqDcFwDZ7KOCD5YsVoOdA5VpnH01UCmGD4DAJGuGgCiQknF4GRJZ7augxWxW9XgdXlHTyAo3h26Bfu4lvz1tqk8G/fm5m093b1+pH4cTqAfZOSFKlW2Uu0R7Z7XQAtd0O9guQ5pCvmZIO1K40GBOa948HufC4ASnWGrAGpj3M6z1EtejN4qd9pkbr5yHu8aEGe5o51A7C8+hBD0rxVv6Ld8rK/4fXev2VaejYAysnZr9kuR3TLG5oHNY5u51O8FPHmHeUeUo0YwahZll1u9SaRwMXhrgrG88ydcLqqwRRWk+rLy1aBBqjpZj5nTaJd9a7FCQvw9Lk34JHpjvk5vrV3plA4N34Tk0QJV2hWTfxR5fsiRA2I0Njw9lMSxH3EwiidsKsN+33LUiLRF4otD8BOWaZ6IYLXlJIVTp9iz91b5kXTuazHIdZOWtxxHht7lCyhH5nql/sHn9XyTJ9IZ6Z4SI576iONhrmDXGnX7zzL35cFhDC6FBJQhDR2m0ojJw84bu1RAzB6+VrNAL0gGJ97dfU5PYB0Gyz6CVzF5YbpUdbyCal5H/uqtrMGdUDX5TvqSd6LBXT3A5OZ7BgIdO5E3H7z9lWfQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(71200400001)(6486002)(8936002)(8676002)(4326008)(107886003)(26005)(2616005)(478600001)(86362001)(83380400001)(64756008)(6512007)(53546011)(66946007)(66556008)(66476007)(54906003)(66446008)(6916009)(316002)(76116006)(66574015)(91956017)(44832011)(5660300002)(6506007)(38100700002)(36756003)(38070700009)(33656002)(41300700001)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0k2Q3hITTltelN4TE1EL2xxempxZjBueW14T25lWjZoUDhialJqSHZCMFlk?=
 =?utf-8?B?WnJlTGF4L1dOWjF6WnRKdlZxQnNGb2JKQVEvSjlEemJ5Rm4wVzFMbE42SCt0?=
 =?utf-8?B?RUhoOVBRVTl6UWwrOVR1WVJBSUcyZm12cXBIZ1I0QnpkeHZnV25CeFRacjlx?=
 =?utf-8?B?YUl6MitRZzlrOU91Ui9jdExvM2FwSWNoN241ZHpySytKSVh1Z0VvekxIZmty?=
 =?utf-8?B?SkRtc0NyQzNwenRYZzgzK3FHVjdtN3FDVDRrSFk1Y0RZenVKY0Q0aFZVRXFn?=
 =?utf-8?B?RUhyMXVBS0czTG5BNmZiNGpoeHN5OU5SZEw1dHVuNTE5Njd1NTY2bktIRmxN?=
 =?utf-8?B?cXRmQ2IxOWMzTXFkNFJ4RGVzNnpFRlNMaWozcUptTG9Hc2hieTZJSEdGbU5n?=
 =?utf-8?B?dWZRL2FRMmdUTjY4eFI2eXNUcHVxNWI2MFRQWFBVRVNQNGJNK0FkMmNIWWVO?=
 =?utf-8?B?dW9FbzV6akxvNG5kblBwckptbzVEUDdrU3ovS3Z1V3lMUElwbUkrbE1jTXNq?=
 =?utf-8?B?Zy9iN1hQOFNKRllKKzNOdTY2TWZncS9YUVkwY1JCR25BcDZBYS9haEY5YUVq?=
 =?utf-8?B?aExWZktDRFg1TTRyU0ZKejF4VHMwS3hGTTI2aTVpREVGa3JLOFFnT3hvckph?=
 =?utf-8?B?TzZnT2RvV3NiWUUzMmZ0a09CcWVlV05CUHVTN1NFQjVUcUtuM2NQV0tteEti?=
 =?utf-8?B?bUpnaXFSYXBCQlNFTHVVT2FxUTR3cUd4bFNhYzRMSDJNbjAxRVBUNDFnNW5w?=
 =?utf-8?B?S2owaGV6NWJPc3BweWVrYk91N2cvTFhMVDNqaFhqeWc5U3VGa1YySWdjVlA2?=
 =?utf-8?B?bFltZ0lZU25Sdk9SMmd4Y0J0cTd4MllWSm9uQmVNWEw4TlprRklDL0VRa0Jh?=
 =?utf-8?B?WnhXQ0hpNjVMdnMwOEFHMUNFTm85ZlZjWXIwa1VIQXlhZEJyRXUyUGVnWURY?=
 =?utf-8?B?Tm50akVTMEU5NWkwaG5wNnNuQUxPcjVoZFUxRGFDaDBCTE5CZmdlemw1NlFH?=
 =?utf-8?B?YjhTTmIyc0ZEQk1la0xXWjdyTzBXMmFmc0N5NG1MN1FEMVpFYUZSM0p2VzBS?=
 =?utf-8?B?WGxmaXpsVHF5eUFBNEVTak5ia1ltNmRLcGxjOVpkMG9UNWZ5R21pTlg1RE81?=
 =?utf-8?B?bldLQ3VKOFZCZ1NXZUVjZlAwcmZQdFh4TGh2aitWSE5vT0Z1c3dDdzc1K0F1?=
 =?utf-8?B?OGU5bWlpWUNZUDh6U0tpWGFkdVZhbnRXK2JxRzJzTjIvTDd5OVBrcHRjS1Jj?=
 =?utf-8?B?UUJaUkRwdkhyV0xEZ0hLS1I4QzNGZU1UWXIraXJ6am9LL2JpbTYwRHRzUENy?=
 =?utf-8?B?K0FKUGRkR3p0bXQwZk5iMGVWblk5d0dlcElmVjluNkp1dUF2TUJNMGlUV01x?=
 =?utf-8?B?bnRaZjZPVnRiYllnNUNCbFBpdWZuVTVuTk9wSGU0UjFocWFMb3lKQ2RJSG5i?=
 =?utf-8?B?YmV2cDFHRkR2UjM3ZGtieWtwdHdSVW9ydjYvYzdOdlA5K0t4Wlk3RnMvUGFQ?=
 =?utf-8?B?ejV1NmlCbm52MXlGbFVuc29UcTZBNE1iclVRKy8vMXlTVWhmUEJUZk9jY2Nu?=
 =?utf-8?B?dDl6SUJkTzdVczZ2TXhoclpWbGtFcGFNTGhTS3FySTdSNFcybGlNNjdJNVRi?=
 =?utf-8?B?dkdxVnYzUHZTSzJmdDVGaFVPWEF4Z3Z5dWNMYnhJL2VDN1dhVlFhanBGeVZK?=
 =?utf-8?B?NW81bURkZkl1WFdhQmxaWVdKOUg5b2ZEU1dLSHNoNklXOE50R2p3VEhyMzBV?=
 =?utf-8?B?WUNJa3R6ZldlSkZyUGl3WUo2U2FJaW1xUDR5TCs4cFZKb2pGQ3NLV3Q4WmF2?=
 =?utf-8?B?Qm1QbG5BRVZLRVE3THNBS2MrempzM08ybTcxOHgrV2FnMG52Ny81NllJMm1p?=
 =?utf-8?B?L2VKZWZnVzlSakdhNlBCV0c5TDAwc3AvRVM3RnNwT1czSkJsVHMrVjJDc0Rq?=
 =?utf-8?B?UGNrdzJzVGQwcUQ2dFkrZ3FZaGVUUkVnSDRneFV3bGI4WUdSRElmM0JvU1Iw?=
 =?utf-8?B?WE9kR0svY25maEdUdWtvYnNsSXBiR2FBaXlwdTEzRW5NS0ppQmRNbXUyNHQ3?=
 =?utf-8?B?T3l5QzlGZEd6TjJJb2ZXRUFSckI4eEF6MnVONFpMNzdhSkJjeGhqaUtOaThv?=
 =?utf-8?B?ZjdZNVphb2xFWW9YOWkzdjJzcjdaNm5YYmtQQ0NKdG5oOWorazRwdDZxZjYw?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96D06DD3B7FA85449599D6643A24127A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vIDs5IJqRcP3uBmC4jHqlP6CEqd1IgZKQqPuaZ6orMtY2mloJHwthDSF3EV16Hp1Lk3ePIyH0DEPkGtKCgyja/Sdym1xIjEWiv3EvolklsFlJffZx2VPBi80U9xcdHHnUwd57ZzslXkkUtR1eorLfnuakjGg0TtlRE9t2xipmPUCqWMBc4lw+yJudryrbGb+zDNg9R5ps5N8D7BSIaSkTH7N4PBwfNjzILWDZkYsSpJqnES0CaZB2SzhzhRu4Qf/GNXe7oDGNMOCEI6PTG1MB8lMwzRUaBLgr66y+EoHGN9slB7a1nOyN/0wzUqE3CO53H1QSVy9mSiHtCqjl56jISqbeOgpZ/kPqanLHj0EKCwiAa4/jKU3Ma3tIl+1SwN3tDz/gXkUIWmMPiBn4eDMLVjL5u1595BegoiwmuKCt1UBwcZZ0WcFCxi659R631QYFaC4XJKA7H54/G83IJBBJB5MD67KJJ8WK3ElBxRWen3GLQhh924NXjdzfxL3YtBUq8giZ3hNddwisT91aSct29GTVZ02tQGt9qLRQ+NL3clhRZGy8kgLol3k64J2Fw8hhuJx8TyKSBiJRnqefPqox8n6+/6DvNEkTwX4bXpjE28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f5064-57ff-4cae-40d2-08dbfe539d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2023 16:25:28.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeMK7eONBSPdNE5p+XSWpHBqhXKG4D3EYlc6D6g/3w0oJfkKxx+cb+RNyPBrcPhogn5iRyU73wmIGPL81wnJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160126
X-Proofpoint-ORIG-GUID: fi3BdCk9mWv8hB0fFeV-qcz5MkbIRMMj
X-Proofpoint-GUID: fi3BdCk9mWv8hB0fFeV-qcz5MkbIRMMj

DQoNCj4gT24gMTQgRGVjIDIwMjMsIGF0IDAwOjU0LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDU6MjnigK9BTSBI
w6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gV2Ug
YWxsb2NhdGUgc3RydWN0IGF1ZGl0X2VudHJ5IHVzaW5nIGt6YWxsb2MoKSB3aGljaCBhbGlnbnMg
dGhlDQo+PiBzdHJ1Y3R1cmUgYXQgaXRzIG5hdHVyYWwgYm91bmRhcnkgYW5kIHNvIHVzZXMgdGhl
IGttYWxsb2MtNTEyDQo+PiBTTEFCLg0KPj4gDQo+PiBUaGF0IG1lYW5zIHRoYXQgdGhlIGxvd2Vy
IG9yZGVyIDkgYml0cyBhcmUgZXF1YWwgZm9yIHRoZXNlIGFsbG9jYXRpb25zLg0KPj4gV2hpY2gg
b24gYXJjaGl0ZWN0dXJlcyB3aXRoIGxpbWl0ZWQgTDFEIGNhY2hlLXNldHMgd2lkdGggd291bGQg
Y2F1c2UNCj4+IGNvbmZsaWN0IG1pc3Nlcy4NCj4+IA0KPj4gV2l0aCBTVElHIGNvbXBsaWFudCBh
dWRpdCBydWxlcywgdXAtdG8gMjYgTDFEIG1pc3NlcyBwZXIgc3lzY2FsbCBoYXZlDQo+PiBiZWVu
IG9ic2VydmVkLiBUaGlzLCBvZiBjb3Vyc2UsIHZhcmllcyBmcm9tIGJvb3QgdG8gYm9vdC4NCj4+
IA0KPj4gRml4IHRoaXMgYnkgdXNpbmcgYSBrbWVtX2NhY2hlIGFsaWduZWQgYXQgY2FjaGVsaW5l
IHdpZHRoLCB3aGljaA0KPj4gZ3JlYXRseSBpbmNyZWFzZXMgdGhlIGVudHJvcHkgaW4gdGhlIGxv
d2VyIG9yZGVyIFZBIGJpdHMuIFdpdGggdGhpcw0KPj4gZml4LCB3ZSBvYnNlcnZlIGEgbWF4aW11
bSBvZiAwLjggbWlzc2VzIHBlciBzeXNjYWxsIHVzaW5nIHRoZSBzYW1lIHNldA0KPj4gb2YgYXVk
aXQgcnVsZXMuDQo+PiANCj4+IFRlc3Rpbmc6IHJ1biAicGVyZiBzdGF0IC1kIC1yIDUgLi9zeXNj
YWxsX2xhdCIsIHdoZXJlIHN5c2NhbGxfbGF0IGlzIGENCj4+IHNpbXBsZSBnZXRwaWQoKSBsb29w
LCBydW5uaW5nIDEwMCBtaWxsaW9uIHJvdW5kcy4gVGhpcyB0ZXN0IGlzIHJ1biAxMA0KPj4gdGlt
ZXMsIHdpdGggYSByZWJvb3QgaW4gYmV0d2Vlbi4gQWZ0ZXIgZWFjaCByZWJvb3QsIHdlIHdhaXQg
dW50aWwNCj4+IHRoZSBsYXN0IG1pbnV0ZSBsb2FkIGlzIGxlc3MgdGhhbiAxLjAuDQo+PiANCj4+
IFdlIGJvb3QgdGhlIGtlcm5lbCwgdjYuNi1yYzQsIHdpdGggIm1pdGlnYXRpb25zPW9mZiIsIGlu
IG9yZGVyIHRvDQo+PiBhbXBsaWZ5IHRoZSBjaGFuZ2VzIGluIHRoZSBhdWRpdCBzeXN0ZW0uDQo+
PiANCj4+IEJhc2UgdnMuIGJhc2UgKyB0aGlzIGNvbW1pdCBnaXZlczoNCj4+IA0KPj4gbnMgcGVy
IGNhbGw6DQo+PiAgbWluIGF2ZyBtYXggICBwc3RkZXYNCj4+IC0gMjA1IDIxMCAyMjcgNi40MDIw
MDANCj4+ICsgMjAzIDIwMyAyMDkgMC45NTQxNDkNCj4+IA0KPj4gTDFkIG1pc3NlcyBwZXIgc3lz
Y2FsbDoNCj4+ICAgIG1pbiAgICBhdmcgICAgbWF4ICAgcHN0ZGV2DQo+PiAtIDMuMTQ3IDEyLjAx
NyAyNi4wNDUgNi41NjgyODQNCj4+ICsgMC4wMTIgIDAuMTAzICAwLjgxNyAwLjIzODM1Mg0KPj4g
DQo+PiBpcGM6DQo+PiAgICBtaW4gICAgYXZnICAgIG1heCAgIHBzdGRldg0KPj4gLSAyLjA5MCAg
Mi4yNTkgIDIuMzAwIDAuMDYwMDc1DQo+PiArIDIuMzIwICAyLjMyOSAgMi4zMzAgMC4wMDMwMDAN
Cj4+IA0KPj4gVGhlIGFib3ZlIG1ldHJpY3MgYXJlIGFsbCBpbXByb3ZlZCwgYW5kIHRoZSBMMUQg
bWlzc2VzIHBlciBzeXNjYWxsIGhhcw0KPj4gYSBzaWduaWZpY2FudCByZWR1Y3Rpb24uDQo+PiAN
Cj4+IENvLWRldmVsb3BlZC1ieTogQW5rdXIgQXJvcmEgPGFua3VyLmEuYXJvcmFAb3JhY2xlLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IEFua3VyIEFyb3JhIDxhbmt1ci5hLmFyb3JhQG9yYWNsZS5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUu
Y29tPg0KPj4gLS0tDQo+PiBrZXJuZWwvYXVkaXRmaWx0ZXIuYyB8IDE0ICsrKysrKysrKysrLS0t
DQo+PiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9hdWRpdGZpbHRlci5jIGIva2VybmVsL2F1ZGl0Zmls
dGVyLmMNCj4+IGluZGV4IDgzMTdhMzdkZWEwYmIuLmI3NTk3YTYzYTM5NTAgMTAwNjQ0DQo+PiAt
LS0gYS9rZXJuZWwvYXVkaXRmaWx0ZXIuYw0KPj4gKysrIGIva2VybmVsL2F1ZGl0ZmlsdGVyLmMN
Cj4+IEBAIC04MCw2ICs4MCw3IEBAIHN0YXRpYyB2b2lkIGF1ZGl0X2ZyZWVfbHNtX2ZpZWxkKHN0
cnVjdCBhdWRpdF9maWVsZCAqZikNCj4+ICAgICAgICB9DQo+PiB9DQo+PiANCj4+ICtzdGF0aWMg
c3RydWN0IGttZW1fY2FjaGUgKmVudHJ5X2NhY2hlOw0KPj4gc3RhdGljIGlubGluZSB2b2lkIGF1
ZGl0X2ZyZWVfcnVsZShzdHJ1Y3QgYXVkaXRfZW50cnkgKmUpDQo+PiB7DQo+PiAgICAgICAgaW50
IGk7DQo+PiBAQCAtOTMsNyArOTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXVkaXRfZnJlZV9y
dWxlKHN0cnVjdCBhdWRpdF9lbnRyeSAqZSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgYXVk
aXRfZnJlZV9sc21fZmllbGQoJmVydWxlLT5maWVsZHNbaV0pOw0KPj4gICAgICAgIGtmcmVlKGVy
dWxlLT5maWVsZHMpOw0KPj4gICAgICAgIGtmcmVlKGVydWxlLT5maWx0ZXJrZXkpOw0KPj4gLSAg
ICAgICBrZnJlZShlKTsNCj4+ICsgICAgICAga21lbV9jYWNoZV9mcmVlKGVudHJ5X2NhY2hlLCBl
KTsNCj4+IH0NCj4+IA0KPj4gdm9pZCBhdWRpdF9mcmVlX3J1bGVfcmN1KHN0cnVjdCByY3VfaGVh
ZCAqaGVhZCkNCj4+IEBAIC0xMDgsMTMgKzEwOSwyMCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBh
dWRpdF9lbnRyeSAqYXVkaXRfaW5pdF9lbnRyeSh1MzIgZmllbGRfY291bnQpDQo+PiAgICAgICAg
c3RydWN0IGF1ZGl0X2VudHJ5ICplbnRyeTsNCj4+ICAgICAgICBzdHJ1Y3QgYXVkaXRfZmllbGQg
KmZpZWxkczsNCj4+IA0KPj4gLSAgICAgICBlbnRyeSA9IGt6YWxsb2Moc2l6ZW9mKCplbnRyeSks
IEdGUF9LRVJORUwpOw0KPj4gKyAgICAgICBpZiAoIWVudHJ5X2NhY2hlKSB7DQo+PiArICAgICAg
ICAgICAgICAgZW50cnlfY2FjaGUgPSBrbWVtX2NhY2hlX2NyZWF0ZSgiYXVkaXRfZW50cnkiLCBz
aXplb2YoKmVudHJ5KSwgMCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFNMQUJfSFdDQUNIRV9BTElHTiwgTlVMTCk7DQo+PiArICAgICAgICAgICAg
ICAgaWYgKCFlbnRyeV9jYWNoZSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBO
VUxMOw0KPiANCj4gVHdvIHRoaW5nczoNCj4gDQo+IDEuIElmIHdlIGFyZSBnb2luZyB0byBjcmVh
dGUgYSBrbWVtX2NhY2hlIHBvb2wgd2Ugc2hvdWxkbid0IGNyZWF0ZSBpdA0KPiBoZXJlLCBpdCBz
aG91bGQgYmUgaW4gaXRzIG93biBhdWRpdF9maWx0ZXJfaW5pdCgpIGZ1bmN0aW9uIHdoaWNoIGlz
DQo+IGNhbGxlZCBmcm9tIGF1ZGl0X2luaXQoKS4NCg0KVW5kZXJzdG9vZC4gV2lsbCBmaXguDQoN
Cj4gMi4gSSdtIG5vdCBzdXJlIGl0IG1ha2VzIGEgbG90IG9mIHNlbnNlIHRvIGNyZWF0ZSBhIGtt
ZW1fY2FjaGUgcG9vbA0KPiBmb3IgYXVkaXQgZmlsdGVyIGVudHJpZXMsIGVzcGVjaWFsbHkgZ2l2
ZW4gdGhlIG1vZGVzdCBwZXJmb3JtYW5jZQ0KPiBnYWlucy4gIElzIHRoZXJlIG5vdCBzb21lIHdh
eSB0byByZXF1ZXN0IGNhY2hlbGluZSBhbGlnbm1lbnQgd2l0aA0KPiBrbWFsbG9jKCkgb3Igc2lt
aWxhcj8NCg0KVGhlIHByb2JsZW0gd2l0aCB0b2RheSdzIGt6bWFsbG9jKCkgaXMgbGFjayBvZiBl
bnRyb3B5IG9uIHRoZSBsb3dlciBvcmRlciBhZGRyZXNzIGJpdHMsIGJlY2F1c2UgdGhlIGF1ZGl0
IGZpbHRlciBlbnRyaWVzIGFyZSBhbGlnbmVkIG9uIGEgNTEyQiBib3VuZGFyeS4gSU9XLCB0aGV5
IGFyZSB0b28gbXVjaCBhbGlnbmVkLiBUaGUgaW5jcmVhc2VkIGVudHJvcHkgaXMgZXhhY3RseSB3
aGF0IHdlIGdldCBmcm9tIHVzaW5nIGEga21lbV9jYWNoZSB3aGljaCB5aWVsZHMgbW9yZSBMMUQg
Y2FjaGUgc2V0cyB0byBiZSB1c2VkLg0KDQpBbHRob3VnaCB0aGUgcGVyZm9ybWFuY2UgZ2FpbiBp
cyBtb2Rlc3QsIHRoZSByZWR1Y3Rpb24gaW4gTDFEIGNhY2hlIG1pc3NlcyBpcyBzdWJzdGFudGlh
bCBhbmQgdGhhdCB3aWxsIGltcHJvdmUgcGVyZm9ybWFuY2Ugb24gbW9zdCBhcmNocyB0aGF0IGVt
cGxveSBhIHZpcnR1YWxseSBpbmRleGVkIEwxRCBjYWNoZS4gQW5kLCB0aGlzIGNvbW1pdCBhY3Rz
IGFzIGEgcHJlcmVxdWlzaXRlIHRvIGF2b2lkIGhpZ2ggdmFyaWFiaWxpdHkgaW4gcGVyZm9ybWFu
Y2UgZ2FpbiBmcm9tIHRoZSBzZWNvbmQgY29tbWl0IGluIHRoaXMgc2VyaWVzLg0KDQoNClRoeHMs
IEjDpWtvbg0KDQo=
