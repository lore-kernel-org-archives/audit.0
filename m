Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7124450F2
	for <audit@vger.kernel.org>; Tue, 25 Aug 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660235; cv=none; b=saITYhx8XQyuJmsOAWqiy3e/5L/zwBvmlxFAMeT98pdsXVsEjsKpzHyc/sAMplSVsnOgPepQWR3pGM0/fqY36frkwer829AacvLa+b0GKS9Cwf+6qH6v7qHGHVfraHE08H64mpnDzYQXw1URJl9hx2s8M4ipAlGgL9PlwB1HU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660235; c=relaxed/simple;
	bh=+aNhbvb4NWnYzECMUEbZ+vgTHW5Rwu5RUy25CJFxqy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG27hRMHj6Wa5IQP0oo1FixhkovacB/Mj8foWZgTGqDJXza5WsYK8Ieorj2fSoAQ28ooEevLsPPg1sZiGKlW5bDrMbNwjw+BkOKQCjtasBRE6BFrOQOwwEkPdc5iV4c430J8/O/0Nsdjk1ne97lQktkitzEnTNlygf9ClPCCybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrN8rvfF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrN8rvfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aPQpD71iPNHktqTmLmGlSoeiix950435Osg9DHorE4=;
	b=JrN8rvfFh0YNgUuJjJAacrJ4+HL6NCVGdrW/AREAgVF1UN/G9aHZ4AORfq4N/ot15A0PCN
	qqEaqpwhD4MFsME1DmwbcwCS09Q1syN1g1th56mEyq2rzdihPuvRYIoL07gfNyDBoXf0Rb
	Iv3PGfusHOaZqDLkltN8UTURXHQDRDA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-OehdIfWxM-SWDfQVva24Rg-1; Tue, 25 Aug 2026 08:17:11 -0400
X-MC-Unique: OehdIfWxM-SWDfQVva24Rg-1
X-Mimecast-MFC-AGG-ID: OehdIfWxM-SWDfQVva24Rg_1787660230
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15d4224f9dso150134566b.3
        for <audit@vger.kernel.org>; Tue, 25 Aug 2026 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660230; x=1788265030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5aPQpD71iPNHktqTmLmGlSoeiix950435Osg9DHorE4=;
        b=gXw5opNTgokOR5z+0CDeO38GyceuiAq5MfcMfRCgbfWUSPfxE3KNpi0jJvztJSb3ZE
         f/jsp5Etjl5/DiV38jWJOTHpdEyhZpG3yKXQM7pjv4XzbzageEIdoK50n+gwNik50m7+
         1NoxF6VnzKo8jhRT35oQXODe0LnBOk7aULfFLuH4RjWYKMPmvL69WV0AMLUFi1Dfjr5e
         qVvrLT7xb9nqlvGp0h9y9sw8AacKjJgLggcQQP0OTxfOnbp/3JMg/gUB3D51Yid/+WW+
         Bg2ZutWpuz8K6euYBsraoB6oAJTyQALZry5XxbTFjDcNA6qQsKeFCjjwLTthrfdNX1Ua
         lDVg==
X-Gm-Message-State: AFuF++mmwWwScRbMP8/ZYs9LCTZSMZKiU4hH4CdVOHRU7KlJaL5NmGdl
	jdPz6HdH0PupAT3TGhrwP6nOaTcxKJfoRxOi7aigKOt740Y6ymSDASAdIEnyZxOvTDWlKrloesg
	+inPADpg1RowHaWn8ePKB4iHZCjAeH1qH33GTYXFGjaObalsIlhUFdRzRjaTPgc93JQBjlNWcAS
	No5QeAN0PlNKZ4VG0oZf7Q5mWCGc2XM3RrDRSWeRY=
X-Gm-Gg: AR+sD12qHheEDJc2KvoQaByiYJheWJ4I4CVgHFGcVmb8Gsof9QN07mUZi0v9Jcklgnj
	ryWa67W2TrPwodh0PsyA7yhZ9TmForEwc2ghRY3paklugiyk9D11pxsCURaUy41jh8V6n78x8J4
	eSF+qrqcUAeqISIOY/AWAeteCBNvMQXrczAycdy5gE5k3fPVAHOEk+bqAUBWC9G0kyQ8NgKMksd
	o6/+EhDfLp0060326XUsOy4v0h1dsXZ0m3lQNkeRTm2126A5CepVTV3q3etIJHX8Ss2NwmKxWwX
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id a640c23a62f3a-c2492797eb0mr2938421466b.24.1787660230204;
        Tue, 25 Aug 2026 05:17:10 -0700 (PDT)
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id
 a640c23a62f3a-c2492797eb0mr2938414066b.24.1787660229760; Tue, 25 Aug 2026
 05:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807140521.510904-1-rrobaina@redhat.com> <77cb8aa1365ead24eda2ff0800a8ec8c@paul-moore.com>
In-Reply-To: <77cb8aa1365ead24eda2ff0800a8ec8c@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 25 Aug 2026 09:16:55 -0300
X-Gm-Features: AcwNN1WqcsJ8TsrAZWegvJxLNanpAcyuZFh2v1HLYvHFgnfw3TQBpf153wOG1fU
Message-ID: <CAABTaaAiC=CbSQvZLt5uwwNDsdAfsETPFuRs74Znonbkh87spw@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing unlikely hint to audit_dummy_context() wrappers
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mE2V6iVMBAvS3HadkhRHJ-2CZNivWArbxYO5fS6AAVA_1787660230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Mon, Aug 24, 2026 at 7:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug  7, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The inline wrappers: audit_log_kern_module(), audit_tk_injoffset(),
> > and audit_ntp_log() check audit_dummy_context() without unlikely(),
> > unlike every other wrapper in the file.
> >
> > Add the missing annotations for consistency.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/audit.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks.  Merged into audit/dev-staging due to the merge window, this will
> move to audit/dev next week.
>
> --
> paul-moore.com
>

