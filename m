Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7E3D0A4
	for <audit@vger.kernel.org>; Tue, 19 Dec 2023 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aqak32NJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IznCItTC"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJInEX5012769;
	Tue, 19 Dec 2023 21:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=utgSHsp0EYubneKbdSM3w66S+AKihJvLyYY2p/S/oBs=;
 b=aqak32NJsRV1SXZYz4a6kUtqt5MJN7KdtZ5l+w5KXeBEmbjOuWqVdSGH2R8uQwuZjcXB
 CdPPHHbeXyCLiWVPs90SEak7E0CwOjKOSMzZr/RRyBARQ0XrHw5bQ+ysjIMyhCWndtfH
 HgZFXeFIZ4bWctwvr92IIiCEX8N5fg+jr3wS/lTOiXerG7KaNAxFLnbwC5RmJZp3hgdj
 ll/voi+zUaqaA6p0bo7T5FeoKsQjCENc1AzneS8uyLMBy2SGd80CO9m/Nl1nYe82xuYT
 80LMVrSKDr6q2Jpe62NpnXvBrcR0LnaxbQUU8B9wwSTsWuNR3xvMw6N6Ztl0cKBpCygL jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p471c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 21:07:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJKPRRx022320;
	Tue, 19 Dec 2023 21:07:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b7mvxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 21:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHB7oI8cnYaTBUEZcCbjjRj+q8A46FZMc38Mq3ntot19zLE/OnQ2YSAGk1Ou938ObpPnthdHdbfj0cHv5q+zKzyS08XvRsRjeZIzLRR0A6dUnw1FMczDLIh/Q8owHfEVh9L5vdmMXyL9nOfXKCR+giu9TGGLHv7YMXvs/gkg6t4hXVzwzksmvPvFJHYXDAHU3hYoNYdph9AS/C6dDtZTbDPs13K+KPMVJ0subMx9seRRKSKe/LmIFyuvh6Q1yVTaZ0CXu7Pi4VfD2moiNxIhf8LCRWO//9EHLWhs7OzGZ37Y8B666A2/vUSKHAeAS9s722HQNK01HfzZgLVpnhglWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utgSHsp0EYubneKbdSM3w66S+AKihJvLyYY2p/S/oBs=;
 b=K/EvW+Oy8itaGPWTyD//bWFiDXX5Adbfy4lQIw0YKLcN18pAMb3VPCuFNurJQviQN9zu0Lp9q8FKf4BcPJ5IB5r6gz4Q5YhmFr4ReRAmcEx1NXUpBIbku26nX+6hZxzOwTTFuZZsEWO3fe2KWMXJwky7Al7Ceal/ZqiVBh57aVTfsj67GWbW/O3zVBduY7aY79ECwlBP1FRZ1kSKSBIpWTit+TV993faYvmb6LE9QI8m9/HDcrPLIVYQ60MyU8Ro4dZJToKcd0SgM/svR5XSxX3pLGUZLpcWTU1jUvX/aKcQ1EtrcST3EIpVET4uWH/Z6m4J/7f+cA8jPH5/dtdbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utgSHsp0EYubneKbdSM3w66S+AKihJvLyYY2p/S/oBs=;
 b=IznCItTCwhi/TeYZwmpTRfrcMSavatfR1/nTmu0fukgpV5IT1CVuAc/FlaFeGj7ZUhLyO/nVSofxelC65WnJsr6OBfllSjUFUSf3vSksLMvZnIwEpsJnJMz7V/6jxWmtb864zyNE5k1euBtVENG/oUhR25p5nT8tSs8pfq2pheI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5233.namprd10.prod.outlook.com (2603:10b6:208:328::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 21:07:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 21:07:32 +0000
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-2-haakon.bugge@oracle.com>
 <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
 <738EAB12-E8FF-49E9-BD92-4E3630AFDB17@oracle.com>
 <CAHC9VhSZ6cZ32f5z_aLkpSbSnpeFe53+NHNXfjyJzpOZ3x7mFw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Eric Paris <eparis@redhat.com>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 1/2] audit: Vary struct audit_entry alignment
In-reply-to: <CAHC9VhSZ6cZ32f5z_aLkpSbSnpeFe53+NHNXfjyJzpOZ3x7mFw@mail.gmail.com>
Message-ID: <874jgdkijx.fsf@oracle.com>
Date: Tue, 19 Dec 2023 13:07:30 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 92229d23-29d3-4113-8f81-08dc00d6841f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9hvYPL5Sj9gFr3gE4z+o1bvN85FGhLj2vMJvLBDBg1wvzNpKgyd9jGXjRQpPYU5/QboQy4RWCZLuuxOxiM5yFyyHl6fEx+ozah01VWDIkjfNbhxqP3jGuTuEzbsLnORIdBmFljsjwBzTELuDbP/8GBJcIMTIkgrxTaK0N6v8+QJLfiJdy8qxs9Wg8/k3pGqHu8p26pRUGwyzeg6uWkoZrg7Gt2Me9vOKyp7j3UI1qS2Z+fX11oTmG4FNFQXx6LldcHsthOT7YEDwd0Okk5T3jFbzggJ5q+j2DBG3/Ky8E6atWM3EyK0Bpf9ju4OAhjI9qW7uWx5ghxcwulvzTHr8eMn2jAOrJ+Ggplg+tGmujT8QLCxvv6PKkIaEDEdX1f1rkaATjjEIe8644YpznPo07iHD8itnFJF0r3nlAE3uDvPTPFVhvp+rKpNuotFmI0YoiBacE9EgoltaCJAc4DODXjb/X6mPPWVOhIs6ew2FU9Km0pJ4ZlEdg1mt9glDEBbsOSRP6PNG3JeOtBXsYsdvxjzlHPqUznBZGsQqNTcFC02M+URCFpXwhfAO7rWsogpv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6916009)(316002)(107886003)(36756003)(86362001)(26005)(38100700002)(83380400001)(2616005)(53546011)(478600001)(6486002)(66556008)(2906002)(6506007)(54906003)(66946007)(6512007)(8676002)(5660300002)(66476007)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVJSTDhUOW43bmJ3bEFHdFVJeUF6ekRQWDFOZTdHTzlxMytra2YwNktkL0Rs?=
 =?utf-8?B?Ny96RzEyUTZOZW52SVIxS1ZseFdBdFBZNGRSaFB6U0dNb2hMNUpBSGlWU1BB?=
 =?utf-8?B?QU9WSlJ5Y1dzMTVwSmxNQ3ZtRndqWlI1bDNyTnQzc2ljRk85VE5CaEJqU1Mx?=
 =?utf-8?B?emIvcE1MczhrR3RvNkR3OWZlajRrZUlKc0M1c3dBYTJFMmg5SDl4VDludW9U?=
 =?utf-8?B?c05VM2JyT2lLaWR2Vm1ySks2a1BzNDBlSVZyeVpVaWozYW85QlN3cE1idE8w?=
 =?utf-8?B?V0hSYVQzM3Bmd0RuU2tWRXJJQU9yWlpncVR6SE5UblpIZ3JVWVhPYTFhd1B5?=
 =?utf-8?B?KzJ4MkM1R1E5TmNPR1BSakYveTFsU2dlUVNIcFZBN3FjU3Vkc21CK3RSVVZu?=
 =?utf-8?B?RDdadU9Yc2pmbjhMUUYrcDNNTlB6NDVUbnVmaXlRYlpWYkpHTTAxWkNlb0tM?=
 =?utf-8?B?RCtqWm9aWHR1NGNOTUMvbGRVdjBXeS9zd3pNbHBKVi94Mno2NGQrOWJoQ3FL?=
 =?utf-8?B?emJ2NVpOZFJqam5ZSzQvS0hQRVBIZVpwSS9hUk1MRXJqeGNvSVZsOVRQWGVj?=
 =?utf-8?B?UTVWL3lYRUtCZmZqd3dkVm00T1BtZVZjZmg0TFBEVTFpK0tMT0YvQnNvb3cw?=
 =?utf-8?B?WnUwY0tzOTlOd3FCM055aTNTb1RmK21sS2ErbXdweG4yRWJPNkRXd0FaenBa?=
 =?utf-8?B?QWJZVnowbC95ZjhLKzYzTFRqTzFORDd5YTVxRmV6eHNkN2FwMU9HYzVkUG1T?=
 =?utf-8?B?ZUhoWXc2dk5aM25zWVp2SFZkektON1o1c0I3MGtHRFBNZkxnZTZMM21MbDBW?=
 =?utf-8?B?dGRQWGo0QXhxRlZzbGllY0V0WnVTTnQ1OTZGTGJXWVNDT0wvOHZwSDBJaGsw?=
 =?utf-8?B?WTZwWG56ZVQ1YnNjM2UwWW9FV3VOdDgvUjF6RUFnZXV1aUlRMDFKUFRwaEFw?=
 =?utf-8?B?aitpa3VnN3prbHU0MDkyR2Nub0QvcjY3cWZMSEsxd0FPMWowNzYxZ0EvS3py?=
 =?utf-8?B?K3JKMWVNMkljOWJkQU5TV0syb0VQRUZ6ZVZ2VFJ6SHdOQnhoaEJFU1A0RVF2?=
 =?utf-8?B?UGF1ME5wZ3RXN3BwbjdteUNncUN3UUwxMStycXdHTTBOQ0k4WkJSZ0Q3dEky?=
 =?utf-8?B?QThhNTgvM2V5TDZsMmdOODgreC8vTzV0R0YxZ3FKcGs1TVdNaVN5c0RMYnRD?=
 =?utf-8?B?dWZPRU9YaElYU2d3Wk9QWVFwbENZQ0p0dTJac1E1amJzOEU4RWVKdGV0Ni9k?=
 =?utf-8?B?Lzd4WGgzNW0zUFhvNjdUMGFSeXVtSGVHeXVHTFZrSFR5UUhGQVBhbmthMitG?=
 =?utf-8?B?RFMvQ1VKSm1aWUJWYkFMSGl6K29hM0h0RjNNZFVUNkh1OUplaTEvRnNTUENQ?=
 =?utf-8?B?WlltR014UkxTb0pDZnNzeDVjOXNkM1NEcXVWY1pPVUNpenRyb1pUaXRTK2V1?=
 =?utf-8?B?L05rWUswekUyZFdPcGxHL0RidEszVFNtckZlcjhWN2xhRFFMUFlNS3EweVlZ?=
 =?utf-8?B?VVJXMnNsYU1hVFVIc0lDVnUzczRrTjFhSmdETjkyMU1vcUhNUTFzbDE3cWNI?=
 =?utf-8?B?QUxnREZLVlNyOVUyNFN2c2QyYjZlQTJpR091NnNWUDZFa1JDL2xWUXFOckxS?=
 =?utf-8?B?SjRIK2VxbEVaSVJKQ1NHZE5NVDA4eHV2NExoZnVrMWZ6N2pMa3dYMHI1Y1l6?=
 =?utf-8?B?clB2K3g3Z0I2NWhIK3NVWXhBV0RSWWpZM3RYbnB1MGpyUUVQck81M1JCT3h4?=
 =?utf-8?B?ZzRWd0c3N20rcnlUQ04zUEVyYTkyS09nSDdHWi9mVGNuSC9QTkFlQmNBSTZ4?=
 =?utf-8?B?T3FrZWVaRnpRQjZJczhZQUVLd2dkUmk5L05UUGlUZVllSXNLejVvajZVbkdE?=
 =?utf-8?B?Nk5hbGZYeGxmL202VVo4VW12STdJYmtKYzdmaThmMWVlaXBhTzd3V1VEOVRr?=
 =?utf-8?B?ZVltbHZTVThHc3F6aHkrNVlOaVRxWUE3WXBUS0xIU0tFLzh0V2IvZE9Xb0RV?=
 =?utf-8?B?cmRYa3ZPVU9kREo1TFh6L2ZHM053QkhCZm9hMVI4cGtkb0JtWmZCUHlxWnNq?=
 =?utf-8?B?ZHI3TVRyMXZNMU54TkxRQTUxS2pNTzh0dFFLUkQzRHpLOUxjNitLVE0wTHdX?=
 =?utf-8?B?N3c4VXFDMytpdG9OaklVVjdENjhQam9nWk9FVVBoRFdsV1FyeGF4bXN4Umhv?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X8pk2w9uA9cirwjQXRkamyjbvc0ny3zimYPl42nuAy53REVNQ8LzrIjUT6jtle4ikAp+MUsGNId4VqY9r/Z2KSe+61ZFD/SrzEU8Y14cD0K+VWk5+mlcjnVb7FDSnUWAgDwiiPTy/BKyYwJJxHaEklUz/eDuMS8xq/FGABkdBX/lD8sUd/ee2Qs3uPs5yAGa2deY7L1i0lZ/7RKQoYH8hBT6ZEz4FrMluMLlHBVZatBqTw8wWKNIORTb0qCPoFDeCeiIFg0/2W2SFyp8JlIsqQkATXS+TDIM8wDdP4pyjZERNzOS38KnICPdMK2R/Js5mN+ig1tMJt/zVTG4N/2qXtl2cUX2cEr/PsMAlP4EvMHsr+j6FnHDG2m0xKtdzQG9bWBibBLwPxnOvOrMwo8z5FttZW7igg8CGOP87BACTHMjhNv2nD+kzlkzcQuz6QmgK4WoRfy8S6HaI68Jq8KEt/7PMtBIWmvhmq9x3d55EJQqghHWinDkv6SmXW8XtA0w7dqiUrFCu4f/PxFjxBGT1C8bci7kA6E14Fq4p1ZA1rci5Fi+m2LHJwd0lga7jh5vXtyiYMgVXDcDSnQKicJskuGTnmHzT8rxjrrssVpdkgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92229d23-29d3-4113-8f81-08dc00d6841f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 21:07:32.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRuWM48a9sjaHRMRHLKRV1KpOsq3BWq6q20/ISDbWYXwDvERdc//poJp06ARpDdHcLoy9hx2arNzQbu4YVz0D8fKwVjVCTVntKmKxWqcwz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190155
X-Proofpoint-GUID: ZuHiG1ZkTXojmP6F4-4lT-jA5PoeeJtv
X-Proofpoint-ORIG-GUID: ZuHiG1ZkTXojmP6F4-4lT-jA5PoeeJtv


Paul Moore <paul@paul-moore.com> writes:

> On Sat, Dec 16, 2023 at 11:25=E2=80=AFAM Haakon Bugge <haakon.bugge@oracl=
e.com> wrote:
>> > On 14 Dec 2023, at 00:54, Paul Moore <paul@paul-moore.com> wrote:
>> >
>> > Two things:
>> >
>> > 1. If we are going to create a kmem_cache pool we shouldn't create it
>> > here, it should be in its own audit_filter_init() function which is
>> > called from audit_init().
>>
>> Understood. Will fix.
>>
>> > 2. I'm not sure it makes a lot of sense to create a kmem_cache pool
>> > for audit filter entries, especially given the modest performance
>> > gains.  Is there not some way to request cacheline alignment with
>> > kmalloc() or similar?
>>
>> The problem with today's kzmalloc() is lack of entropy on the lower orde=
r address bits, because the audit filter entries are aligned on a 512B boun=
dary. IOW, they are too much aligned. The increased entropy is exactly what=
 we get from using a kmem_cache which yields more L1D cache sets to be used=
.
>>
>> Although the performance gain is modest, the reduction in L1D cache miss=
es is substantial and that will improve performance on most archs that empl=
oy a virtually indexed L1D cache. And, this commit acts as a prerequisite t=
o avoid high variability in performance gain from the second commit in this=
 series.
>
> My hesitation of using a kmem_cache object here remains, given the
> relatively limited and static filter rule configuration I would rather
> use a k*malloc() based approach.

AFAICT, kmalloc() etc only allows fixed alignment. From
Documentation/core-api/memory-allocation.rst:

  The address of a chunk allocated with `kmalloc` is aligned to at least
  ARCH_KMALLOC_MINALIGN bytes.  For sizes which are a power of two, the
  alignment is also guaranteed to be at least the respective size.

I had sent out a patch a while ago reducing the cost of the same
alignment issue. For me the most pernicious part was the fact that
syscall latency was good or poor based on how boot time factors
affected audit allocations.

So while I do agree with your hesitation on kmem_cache not being quite
the right interface for what are static allocations, I think it might
be worth it given the cost.

Thanks
--
ankur
