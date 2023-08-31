Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E6FC83F01
	for <audit@archiver.kernel.org>; Thu, 31 Aug 2023 09:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbjHaJdN (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 31 Aug 2023 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbjHaJdN (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 31 Aug 2023 05:33:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8653CF2
        for <audit@vger.kernel.org>; Thu, 31 Aug 2023 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693474386; x=1725010386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=50DRhyrOgSc651KUEIGCayLyBnWa3ZXBToxPP9dVhOo=;
  b=GBj8ysg8EeSO8d8YhTi2WpL8jt/xqMstFmt5JDNldek3cSAFmYoBc6eL
   c6gEfYBGNycH3R8yCyT0a15GQO+Fr0O99qKHIJ9xBID+uQqcfvql0jSPb
   3gRaLqucLjx9csEQbAEhZ0CF9st7XglL2iUmywjWGwdcS7Llt1nhjyUCL
   FfdMD+Ln8vYaCs7ARTI5xGeH2ihmKODR9n+8apjbzGKEpCXmbQwlNvjxu
   vZseWWowwpGsW+csAlBXJ/bo3KhvdE/jHi+izSPk4kI8VdHfdnb/i54uQ
   nYRUYLoN+oAcn/OxdZ7hnyVOwcEHXuJyqLMQjKLpVvG3ZwocwDWesE+nr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378592328"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="378592328"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 02:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="733029026"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="733029026"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 02:33:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 02:33:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 02:33:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 02:33:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 02:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBcG+7XvpUMVsjYQiNlvYie0TM1NoZNtjAbn/HG3HVonEgmmPsel7wJME0dwIM7kmPnEGYGj/tQbdUeShpO1rhNGxGcLrsFHTsm8f3QFivXq/W9ptMfu7V7W1trVLSKMagzLoaXrH4C66oY4YAqtmqNQvYVgyxdJYbfLAQgwRvBuwguSvPqqV83P4LdW0G+nsXvJz800WKLeIS8yfFHWmrKcI0hz9Xr6FZvatsw6o2Xa/eRt8pSjQzkTl9wNJqwfUbcxQWE0HnOpT8EVJJKnae47zhIndABu8COW/drHlpVVr4UTnQSyAzZa6a6SM0/KBiw6k7s4uliTGELLsji7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50DRhyrOgSc651KUEIGCayLyBnWa3ZXBToxPP9dVhOo=;
 b=Uy9Qs9PUDwDRCfaEu0F+JLxZtaQsX4pJw33wLbVYPNS6g+2h2OGqotCQV44hBQEhYaK3NLir1IFQdwAgE6gcBhcfO6Of1uy08nR1QgeuQ9Z4APWtc83eTDeJ6/M6y6bU+gZfZi58O1yA50TUoC5zgGCZkG7pWNUBL9U5gREN4oShphyRWlR+lnjdzYjOYuos9a/9uGGuQAYsbMqYdVat5y1Ww3wO3zRqmiEV85yJUWMB+WMoSXeoD22PHPRuHEO/PBEkwfIem4qyVR0RqFb7omEJNbze4bXvxwhivV1DbYaj+/it5Fo5PPsy35rkV516ihU/eD1y04Mo7ZXv2CNzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 09:33:02 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 09:33:02 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: Re: [pcmoore-audit:main 1/1] README.orig: warning: ignored by one of
 the .gitignore files
Thread-Topic: [pcmoore-audit:main 1/1] README.orig: warning: ignored by one of
 the .gitignore files
Thread-Index: AQHZ2vjhP2YWrrNO9kmumR8Ti6ApjLAC5uUAgAE+CQA=
Date:   Thu, 31 Aug 2023 09:33:02 +0000
Message-ID: <4d8308622a1513099fe461ed41409c3768d95946.camel@intel.com>
References: <202308301248.hEwyeVEl-lkp@intel.com>
         <CAHC9VhQZFZTaXb_S5YCy9KniVfPBmEQrY74_dMi5cBftZsrwNg@mail.gmail.com>
In-Reply-To: <CAHC9VhQZFZTaXb_S5YCy9KniVfPBmEQrY74_dMi5cBftZsrwNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|SN7PR11MB6851:EE_
x-ms-office365-filtering-correlation-id: d4f6409f-cc3c-4655-1955-08dbaa0545cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qTOvtzw1benkTTI2Hhyu+mkOOdvbjfCin4KLgYX8Nr3yWhC3dA2rMGFWnDVQ6wXggzzPOuLqiZ+SSVy2dY2eCzB39yRujamAmuXggRnDzcb839sQSpmnZkpYbbzUvSulC70KuH/Ow8LxwfKdndZcNVbapMuzN+8jxuUqhIu1FgppxldnYFUUnLEZRwgxs5YrcTp/oeeTSh26R9IvJN6OgRxQu1OE+806CLNPJRLJljmK9QzpzdU2W1H9j+liW3pmHCKIj1auTfTKzOxcK3bk/m/Xb8dY3EfBklQaSqIzdxC5qBy4cX9Ftka0HmKPOgb+cIUPJMRDgRpOvsd3Drq8UmcIfgE6O/WWvoF4+L7wTPjc5dPEUnuA9f5nFDgKnUonJY3rQMfA1VZnKJ2k0C8tD7waAV5R5np1njCFm6arYJm/IIljtE4lVzab3OOQq14kREFilulfiBspp6+oX9VZO+BOa/nn+c+SVxgcyqYm5418+k1JSQ2MSKyoVzdL+BlYsaC8a+DVvYrwKPC1aMrcNKs3hxgjIORJg1pxbjVjrxq9Nrv5H7v+FvBpwFZQRlCUCDEs3I68OrBPXfVHIk0UkxKiXHr8m8968CT4U+Kxcxxryr+17KHqj6VdpPAn1hF0AeSWy2gm98/JseF42JvB1+NaEq53wWIAbK5SXVonCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(186009)(451199024)(1800799009)(91956017)(26005)(107886003)(38100700002)(53546011)(6512007)(6486002)(6506007)(5660300002)(71200400001)(38070700005)(122000001)(82960400001)(4326008)(8676002)(8936002)(478600001)(966005)(2616005)(83380400001)(86362001)(66946007)(76116006)(54906003)(64756008)(6916009)(66446008)(66476007)(2906002)(36756003)(316002)(66556008)(41300700001)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alhjQ204L01ZL1RlM1BsUGV3VkViTEJNOHlOZ1VtRWtZSldZdzNQcC9VVnJy?=
 =?utf-8?B?aWd4RmZ1cXFrVS93Z0dMOU1ab2l1ckxzQTkxSERwUzJHc042ZE55ZnpYTitL?=
 =?utf-8?B?MnRlY2JlTWpCZEZBaGQ1UUxjb3M2VjR1b0VUR0Eya3AzeGZLT0hNWmF0LzA3?=
 =?utf-8?B?RkU3Uy9pUzQ1SFp2ZHNza29VdEtNbndBVHNnSk54K0tKTGc3dENNd3BudWs5?=
 =?utf-8?B?VEJUVTBtdWtSdzZWZnV0VzRtaU51QjZOM2p4bGJiR2ZoWVRub1oyVFJwNEpZ?=
 =?utf-8?B?TnN3YlpXaiszWVluZlRLQ0c5NnJDdFo1bU5INTZDRENrY056SzdoYm5La0U3?=
 =?utf-8?B?SHk1ZFJKbndRejBxQUNENGVuL2pGL0NYM0VkMW5ONjdFRGlVa1RMTHpuL0dM?=
 =?utf-8?B?MU5sNG1CeUpSMHhFa3ZXNVNMeTlPcmFVQmtxeGZsYTEwSVFld2djN0ZIaXJJ?=
 =?utf-8?B?TTVkd1lxOVhqb1RGU2IwZXQrQ01nQ2xuMzFGc3RMV2dhWVB0aXBlOFJIMm0v?=
 =?utf-8?B?SEhyUENPYVZHc3VoU0xxQ2lBa3Qvdk0yT0NudDFBL2xnNUJFZWlWdExWL3di?=
 =?utf-8?B?eXNzOUt3bmpBZUR5anpWcExEUjM3YzZHL1BBWTFtRkIrdmJRUklURGxZQWps?=
 =?utf-8?B?UEtSelB6ZHRlVG83a2dKZ0xCaGtLeDNyMkN6UGhMWEVGeGZtRG5mRmxqSzJB?=
 =?utf-8?B?L1BROC9Wdkp1cGROdEhKV291eWhyVXNiWURmZXR4OHVaMkZSa0ZESmpMY3VD?=
 =?utf-8?B?bTFUSzhtcTFDWncxUi9WMW1ZZ3RjaUFvMUZCRCtxMHpPSXVJSXQ5QjAydWpJ?=
 =?utf-8?B?RUgvb2NSTnVQTHMwdEdiSnZyWnhYWlRZRjdFaXVWTyt2OE42ZS9GYWhEUXIy?=
 =?utf-8?B?cXRMRFNsQVhQZWp0SnplNVFLQmRNUUNCK0VTWit2U1JaSVF0OTlBeGZnYWdn?=
 =?utf-8?B?ZVZLSU5LWVZJUHNWdUNKQjQrdExaTXBHMTBVR0owalJtejBxbEhhNHVwMnQ4?=
 =?utf-8?B?NGt0YmYrcEFDVTdtTVhsZTk2REJYWUxpcXE5QVFMNlExNWxVSWMremE5Vzl5?=
 =?utf-8?B?aGpPR0V2bDVlenFReWxKRUgybURMT3dZcnZWNkkyQ2Z6Tnc1SThKaWRpVDVw?=
 =?utf-8?B?OWRSYThyRzlncHNRN21zb3ArUXNVOXJmSC9PWUx1MkRmNkZRMVAxV1lieVRs?=
 =?utf-8?B?aHFlQ2dDS2kzNzdmMGFzSWFLSUVMbndmTTgrYkRMVi93b0owZTZGaG1ZUDZr?=
 =?utf-8?B?V3FsMmVadUhTVGZxOFYyNzV2UUs5WHNWbUFJRkU5ZmZJbVFPTm9hYXk5bkE3?=
 =?utf-8?B?S1pRVG41dnQ3YkdkQzRzZVNxU1RhSWhkcXhjRHZqSjRBc25YZEpXZlNOU282?=
 =?utf-8?B?aUZ1RGdIM3pUZmZhbkRqZkFWdlRuL0QwaTE0Z1l3amFnT3RLandiQWp1V1VR?=
 =?utf-8?B?dmpMUTk2Ym9YaDdrK0w0aVVYV2Rvemp0NzNBU1ZnMTZucnRjdFdvbHhkVmdH?=
 =?utf-8?B?S1plUUZRTmN3ZWNWbUQwLzN1eUlic05CWmJUaG9xZXlxaExSWGh6NG5VTnlD?=
 =?utf-8?B?Vi9uM1VjQ2JuRituZlNEdzRUOTVDT0x1c2JkSTlMRlhNK2NjQ1Jja0c0T1VG?=
 =?utf-8?B?VmhSTmZiSktyS2hmK0RmMjYzL2k5MlZIbTNxdHdKTklrbU4yNklHVWRvd0Jk?=
 =?utf-8?B?QkxPNEt5enNkUnF4WGdXNWdKL1phMFJuYStmK29MQkkveDU1TWcwbVFseVg5?=
 =?utf-8?B?NmNTSDhpL0VuVUw0UXZkWW80WmZFUUlPZkpSRVFOZFRtR0FFdnoxQkl4dGJD?=
 =?utf-8?B?YkRxYy9iSU9jTTYwQjNZeExaOThsejlpRStBSWNkV0g0aDhqZWlLRm9xN0hl?=
 =?utf-8?B?WnNNaGVNc2Ivc3VCaTlzY0d3RUxMcHhDeE9YTTUvV2FKS092VVZ3dHBKYXV6?=
 =?utf-8?B?MTBONitQYWFxSFpBcjR5Zlp4TUg3Z1FmTFZMdVB6cnhtQ0FnLzdnaXdjd2Zw?=
 =?utf-8?B?ODRhenN6S3A1VVJXSnNDbEdPM0kzLzRrQjdyVFhheWlzSmV6NjJsb0hEWGhO?=
 =?utf-8?B?R1FNQXhqRXkrUFlpWC92cU80SldUQWNuaXVGckFkeEZycHh4T3paMUkrbGRB?=
 =?utf-8?Q?fboLamPP6n24tn1eE1j+X1eda?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE4EA8AD033ED4E9BB2098615150181@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f6409f-cc3c-4655-1955-08dbaa0545cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 09:33:02.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/aAlHmOZwaKMCQhG5aCAA+2ujv9Rw1+yc1xitduRhhTEWlyUhZAxfS/Mxeism+VBcVWjPFQtfjmQ5B5y2W9Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDEwOjI5IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAzMCwgMjAyMyBhdCAxMjoxN+KAr0FNIGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiB0cmVlOsKgwqANCj4gPiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wY21vb3JlL2F1ZGl0LmdpdMKgbQ0KPiA+
IGFpbg0KPiA+IGhlYWQ6wqDCoCA5NGU1ZWY5YjE1N2M2YzM3NzkzNTJhOGQ0MTIxNTQyZjcxZGU1
MmExDQo+ID4gY29tbWl0OiA5NGU1ZWY5YjE1N2M2YzM3NzkzNTJhOGQ0MTIxNTQyZjcxZGU1MmEx
IFsxLzFdIGF1ZGl0OiBhZGQgYQ0KPiA+IExpbnV4IEF1ZGl0IHNwZWNpZmljIFJFQURNRS5tZCBh
bmQgU0VDVVJJVFkubWQNCj4gPiBjb25maWc6IHBhcmlzYy1yYW5kY29uZmlnLXIwMTItMjAyMzA4
MzANCj4gPiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwODMw
LzIwMjMwODMwMTI0OC5oRXd5DQo+ID4gZVZFbC1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4gPiBj
b21waWxlcjogaHBwYS1saW51eC1nY2MgKEdDQykgMTMuMi4wDQo+ID4gcmVwcm9kdWNlICh0aGlz
IGlzIGEgVz0xIGJ1aWxkKToNCj4gPiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9h
cmNoaXZlLzIwMjMwODMwLzIwMjMwODMwMTI0OC5oRXd5DQo+ID4gZVZFbC1sa3BAaW50ZWwuY29t
L3JlcHJvZHVjZSkNCj4gPiANCj4gPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRl
IHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhDQo+ID4gbmV3IHZlcnNpb24gb2YNCj4gPiB0
aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+ID4gPiBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gPiBDbG9z
ZXM6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwODMw
MTI0OC5oRXd5ZVZFbC1sa3BAaW50ZWwuY29tLw0KPiA+IA0KPiA+IEFsbCB3YXJuaW5ncyAobmV3
IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+IA0KPiA+ID4gPiBSRUFETUUub3JpZzogd2Fybmlu
ZzogaWdub3JlZCBieSBvbmUgb2YgdGhlIC5naXRpZ25vcmUgZmlsZXMNCj4gPiDCoMKgIHRvb2xz
L3BlcmYvdXRpbC9icGZfc2tlbC92bWxpbnV4L3ZtbGludXguaDogd2FybmluZzogaWdub3JlZCBi
eQ0KPiA+IG9uZSBvZiB0aGUgLmdpdGlnbm9yZSBmaWxlcw0KPiA+IMKgwqAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYXJtNjQvdGFncy8uZ2l0aWdub3JlOiB3YXJuaW5nOiBpZ25vcmVkDQo+ID4g
Ynkgb25lIG9mIHRoZSAuZ2l0aWdub3JlIGZpbGVzDQo+ID4gwqDCoCB0b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9hcm02NC90YWdzL01ha2VmaWxlOiB3YXJuaW5nOiBpZ25vcmVkIGJ5DQo+ID4gb25l
IG9mIHRoZSAuZ2l0aWdub3JlIGZpbGVzDQo+ID4gwqDCoCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9hcm02NC90YWdzL3J1bl90YWdzX3Rlc3Quc2g6IHdhcm5pbmc6DQo+ID4gaWdub3JlZCBieSBv
bmUgb2YgdGhlIC5naXRpZ25vcmUgZmlsZXMNCj4gPiDCoMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2FybTY0L3RhZ3MvdGFnc190ZXN0LmM6IHdhcm5pbmc6IGlnbm9yZWQNCj4gPiBieSBvbmUg
b2YgdGhlIC5naXRpZ25vcmUgZmlsZXMNCj4gPiDCoMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2t2bS8uZ2l0aWdub3JlOiB3YXJuaW5nOiBpZ25vcmVkIGJ5IG9uZQ0KPiA+IG9mIHRoZSAuZ2l0
aWdub3JlIGZpbGVzDQo+ID4gwqDCoCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vTWFrZWZp
bGU6IHdhcm5pbmc6IGlnbm9yZWQgYnkgb25lIG9mDQo+ID4gdGhlIC5naXRpZ25vcmUgZmlsZXMN
Cj4gPiDCoMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9jb25maWc6IHdhcm5pbmc6IGln
bm9yZWQgYnkgb25lIG9mDQo+ID4gdGhlIC5naXRpZ25vcmUgZmlsZXMNCj4gPiDCoMKgIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9zZXR0aW5nczogd2FybmluZzogaWdub3JlZCBieSBvbmUg
b2YNCj4gPiB0aGUgLmdpdGlnbm9yZSBmaWxlcw0KPiANCj4gSSBoYXZlIG5vIGlkZWEgaWYgdGhl
cmUgaXMgYSBwZXJzb24gYXR0YWNoZWQgdG8gYW55IG9mIHRoZSBhZGRyZXNzZXMNCj4gb24gdGhl
IFRvIGxpbmUgYWJvdmUsIGJ1dCBwbGVhc2Ugc2VuZCBhdWRpdCBrZXJuZWwgaXNzdWVzIHRvDQo+
IGF1ZGl0QHZnZXIua2VybmVsLm9yZ8KgYW5kIG5vdCBsaW51eC1hdWRpdEByZWRoYXQuY29tLg0K
DQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UuIFdlJ3ZlIHVwZGF0ZWQgdGhlIGJvdCdzIGVt
YWlsDQpjb25maWd1cmF0aW9uIHRvIHNlbmQgYXVkaXQtcmVsYXRlZCByZXBvcnRzIHRvIGF1ZGl0
QHZnZXIua2VybmVsLm9yZy4NCg0KLS0NCkJlc3QgUmVnYXJkcywNCll1amllDQo=
