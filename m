Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE53845C5
	for <audit@vger.kernel.org>; Tue,  3 Mar 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538088; cv=none; b=ks7sXQws7+zOxOoHrCTgVlKUDiN4U4cHXVEpIcc9C+Nwd7/RUqJvWvOoEftAamUh/S8MOBr6uZ7Twp9k/fhSknP7WRJL240SjOj8EQzF9ajF983PYZXattO66/zzkkhqgzJSHCtcyhilPKZ6Wm4hHC77Kh5OASv/0MLDictr5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538088; c=relaxed/simple;
	bh=tT3XraOmUDhdwwiZtacJiKhi8vGUkzCKDpzOqeqOaEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gre98BBQP8VeD5Ys/PCLxn6rzq/a3zcqsktyIXio2zA/ePUp3y8Jj5JZ9EdJwkfSbteWJ96PulJIbJDDLR/pIpKVRGP5tspxeePboEDVeDnOChAgfi5hmc4OfRC2+Z0dZrSCp9jfRQabcC1qcgNCYBVWbp+pJXXsL7WaJ63WQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuitwkqZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuitwkqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772538086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyJhgA5ni6c1hXByJ4ECzhuOtlpdrCAVzSZXI0nieGU=;
	b=PuitwkqZW9YfO2PpyY/p5dmcz7RTogouvKhABr9vZO6ESwT+HSMWllvABq07D8UQTL7uvF
	JGRdlqq024E2F9vn2nx6akWn0ysCbQ9v8ZRZX5u5Z/xN8K9Qz+eDvi0KD0mLVtZZSEKhJ1
	fAF65v7GWgPWty2+yan+Pk6rT6E4TpY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-7wOzY_UIMmKXdrYzjHEeqw-1; Tue, 03 Mar 2026 06:41:24 -0500
X-MC-Unique: 7wOzY_UIMmKXdrYzjHEeqw-1
X-Mimecast-MFC-AGG-ID: 7wOzY_UIMmKXdrYzjHEeqw_1772538084
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b801784f406so629313166b.0
        for <audit@vger.kernel.org>; Tue, 03 Mar 2026 03:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538083; x=1773142883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyJhgA5ni6c1hXByJ4ECzhuOtlpdrCAVzSZXI0nieGU=;
        b=am239RQ8f98tMpP1CC2Chi/29x/OKr5xDH5jyIgDfPq7EvHrkqHgfJ7o0LACxmbPY5
         HYmiWLr3EbMDNdN80Sfa1w0SOu8t0U3eV0BbiPkKo0ECITmg0dPCOjph4LRarCXXpwXG
         qrG6iyG5uxHmjB6gLV1YV8MhZKJibUfeFGCQeMfcVYQN4fGqYdAXJ7cxAl7/iMcJCaDi
         TqdEOr26/Ujd2d+4a1g1V+YyC6W2kb5204UHXgeMg161MRXAnSRvOe4FoeqYvkB/+azO
         +YumnvZSoY+Txe5938rHmeSIQByuzPYWwK4oT0S4OOCd0ES1h5t+toGqiyGtKxZpVnis
         NviA==
X-Gm-Message-State: AOJu0YwhFZgkMtNkfugGNBGhISnRbHYBXHhTjkcvpn0btmmK2vGtsWSZ
	7+43Fjrq6RCMC5FU7hl9QlbtvgrJ1Nlcz4jvCwDkN1xMtAAjbx2/FDm+dRuFKltDr3KqPxOewWW
	ZOhhM4R3ojPUBTOoXrlmXkm7QcMUBkumf8FrqtqceyI3kNldE9gFQ4z6XV9xOjk/DncqXijS18n
	kjXbZ5etq/dPrPoucF/T7IkCXN3SxyQro=
X-Gm-Gg: ATEYQzyHr5MAJGnZdpYQp80R4kPRk9JNfJ9w3da+EjMpKeDVLcKuMbKJRpQZkA7KbCB
	r6PdF8Xxmid8bOjc0M6/iEMTZlS3QpTz6LZw1KiZibJJwkrczKbZabqgTkgQh54HYaqCaCRQX8l
	cEJKUn07dHEmml2tQnF/izaMsxwF64nOMa3wY9bwMfuix5qQ5/gVCDr9Ff1PHO67wOcdQLJC+jh
	/bmOsfVsShxPVY8EodXOmU+CaguijYqsys+gKTbU7OrrqjLonyLT0msk3A0J3dybBg=
X-Received: by 2002:a17:906:fd84:b0:b87:3168:2ccc with SMTP id a640c23a62f3a-b93764ba217mr948374666b.39.1772538083594;
        Tue, 03 Mar 2026 03:41:23 -0800 (PST)
X-Received: by 2002:a17:906:fd84:b0:b87:3168:2ccc with SMTP id
 a640c23a62f3a-b93764ba217mr948372666b.39.1772538083088; Tue, 03 Mar 2026
 03:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226181338.2526777-1-rrobaina@redhat.com> <c0d6360d2ad56225bcd3b3c8fa196d71@paul-moore.com>
In-Reply-To: <c0d6360d2ad56225bcd3b3c8fa196d71@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 3 Mar 2026 08:41:12 -0300
X-Gm-Features: AaiRm52D6qlKr7EczTqUchSKpfXjCyys3uKnwF6bL9QVhwehar4KCzDD2tic7_8
Message-ID: <CAABTaaBJ9tMv=RfNYygM4h4ceKBG23UOrgx-oSzMBtE11tFdtQ@mail.gmail.com>
Subject: Re: [PATCH] audit: remove redundant initialization of static
 variables to 0
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: goOgmzJ_ALUQKE33OkTJ46QswFL0nRlUI3OCOMHmDkQ_1772538084
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Feb 26, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Static variables are automatically initialized to 0 by the compiler.
> > Remove the redundant explicit assignments in kernel/audit.c to clean
> > up the code, align with standard kernel coding style, and fix the
> > following checkpatch.pl errors:
> >
> >  ./scripts/checkpatch.pl kernel/audit.c | grep -A2 ERROR:
> >  ERROR: do not initialise statics to 0
> >  +    static unsigned long    last_check =3D 0;
> >  --
> >  ERROR: do not initialise statics to 0
> >  +    static int              messages   =3D 0;
> >  --
> >  ERROR: do not initialise statics to 0
> >  +    static unsigned long    last_msg =3D 0;
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/audit.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!

