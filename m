Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D7412BEB
	for <audit@vger.kernel.org>; Mon, 10 Aug 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375169; cv=none; b=S7o77Sf0LRyNWXYLoJxWs4UciXCBbTt/S7OPYT0gYccL04YP8CmB83Q6/mSRRUr6Ph4JszZh/YOmU83Nf/vc9k/9uAmcnxHq8SqaD/BsvpcGG9t7gLM7Yor/EGawMTL8Hsa7tNWCL5jJSWrQctiSw4CFvtDpEYPwDsCUgOIcVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375169; c=relaxed/simple;
	bh=dpZiQBwARYYQMbWj4//9MJFrvwazYr7z97ABOnM2rVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRgHNRNhlC5qo8ZSouHks5w57xRdqN2wGrfMC2gtie1ndQtEe9GJ31x88BMmWWlWxB9NaE81riAbXdC/EO6ZYUHGlHtmM28Ju4r58Tpisryipo8DYaBI7ywOrtkYN64kgsZd7LgZLwu7gOLIEFbd6xGu1pUdSyMIbfiVp934q2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG1xntMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG1xntMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786375166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aGeKhp/YdrSWU4TlpimZZAVTCA+FBWr72fTgAkOvA8=;
	b=OG1xntMPlSAlbqTLAP+bNXN8LpIlRCfnvE7qdzMBJaZtzCaKLbtKI8H/UmrpGoDtJtQdMo
	Za5b4MQmJdP6Z6VccaHjYHVMGS+rvrtmJUf2BZThygNzc/C5tD6GXrwfKCKb5LjUWWl1sN
	BrcucddLK/HiGk65ZOZeyzl5+23BoHY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-JCOSopBhMa2Vcf7PR3xBGw-1; Mon, 10 Aug 2026 11:19:25 -0400
X-MC-Unique: JCOSopBhMa2Vcf7PR3xBGw-1
X-Mimecast-MFC-AGG-ID: JCOSopBhMa2Vcf7PR3xBGw_1786375164
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so27677565ad.3
        for <audit@vger.kernel.org>; Mon, 10 Aug 2026 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375164; x=1786979964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5aGeKhp/YdrSWU4TlpimZZAVTCA+FBWr72fTgAkOvA8=;
        b=aYoa/Atxqf6zv6+vthXsRb/JnK2juy+HSbAFrBKdm+p7lQaum9SVm0fE9snTDLOzYN
         f7NYYi916ezvKgYINFUOLrtYmlzaTgbVdD7ctjsMLxaQdV3+SAHPzxVhSdNOtIBvhno+
         4K4mDl4SBiA+qX+IuyN1XRoZtomcJa8Z9VLA1AnYgr2E29DAOZ9hodHWjomV8vXDhUpK
         qNIHlvWawrehbIbl9DdG8D9f6q3iGliOQRRfIpRYZn687j2zlvK+sxR5Iq+JZFTpfyzI
         t1ui3VcgeEDcc9/fb4rdduw+fcL5s01iNjtFFjuGFJqiN55P5RwAa6gCRUlbqTASXoSY
         pPyw==
X-Gm-Message-State: AOJu0Yz3KwSQ6LbXYw+x88+QmnjiHNngluouTWKl40DLfEm00tmEyDM0
	jMgphpk3eNyPzMMLhmH+vhSB57Dy1AXgBd4z38wTHBBMm6gqWN6gG39KjHCvPA0snBj7ruk0/o5
	FMUXLBHUZ88DE4kbRC6sGintgBP9VL+RO3KYMzYRivFCubbHPJVv1fLXVyMMhi1pEHnFOgZMhYN
	omGBxetJgys0aXB/WXO1ofP1KmHUM8D7U=
X-Gm-Gg: AR+sD138tM2bYrSE/2C+LhqAXtkCuhoNiIJ5EAiZfdjKxGn7W+DXFwxk5x5A/7tq2kc
	SFb+HYFIgX9tXWwzZJa0kcyCK0phvMm1swGSJgvokiEF35kebWrAVdOMJq8+gOJU/+Jeu1Q2KhS
	az0B5GsUm35ammfxlJaHf34Effs1MGV26eO4Bt0XXo/5LyxevLfSJLXM1waEBXxfnRRFYZjKfjY
	N8l02VpmJWwOnoShBLrIBazur8jbsMTebguKDbGi4+NoPjcFfoA9jFYcFa+LNlsjAFUaPtLOExj
	yCw=
X-Received: by 2002:a17:902:f68b:b0:2c9:e846:a57e with SMTP id d9443c01a7336-2d2a55ecec6mr234929825ad.0.1786375164046;
        Mon, 10 Aug 2026 08:19:24 -0700 (PDT)
X-Received: by 2002:a17:902:f68b:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d2a55ecec6mr234929065ad.0.1786375163494; Mon, 10 Aug 2026
 08:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810125726.775689-2-rrobaina@redhat.com> <D8FC4B83-AC7B-4ECC-AA70-17DCE5AB2AD6@grrlz.net>
In-Reply-To: <D8FC4B83-AC7B-4ECC-AA70-17DCE5AB2AD6@grrlz.net>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Aug 2026 12:19:10 -0300
X-Gm-Features: AUfX_mw1SA6mwU-Em1gQCNzY1CPao8FAbDCpQj345UTOuE652uE8WjE_8J-XMsg
Message-ID: <CAABTaaDWFgz=kJr8YHx8NpKwuWnkCfjf==3noP36x83Zxv5APQ@mail.gmail.com>
Subject: Re: [PATCH] audit: use copied skb length in kauditd_send_multicast_skb()
To: Bradley Morgan <include@grrlz.net>
Cc: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YM-virRdOXDd1vJmHW5V-GYunDRBfZmenxoh3WWrMSg_1786375164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:32=E2=80=AFAM Bradley Morgan <include@grrlz.net>=
 wrote:
>
> Hi Ricardo,
>
> > -     nlh->nlmsg_len =3D skb->len;
> > +     nlh->nlmsg_len =3D copy->len;
>
> Fine. skb_copy() does skb_put(n, skb->len) and nothing touches
> copy->len in between, so the two are always identical.
> Which is also why "safer" is a bit of a stretch, it prevents nothing.
> Feel free to bikeshed the changelog wording on that.
>

Thanks for reviewing this patch, Bradley. I agree with you on the wording.

> If you ever want a more interesting cleanup here, the real quirk is
> the line above: the unicast path sets nlmsg_len to skb->len minus
> NLMSG_HDRLEN, this one uses the full length.

That's interesting, maybe moving the nlmsg_len fixup out of
__audit_log_end() would be better. I'll look into it.

>
> Well, why not, please add:
>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Thanks!
>

-Ricardo

