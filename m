Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64C1F427C
	for <audit@vger.kernel.org>; Tue, 25 Aug 2026 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621315; cv=pass; b=G9qKTZLcRFFmmOiUiCutymp9PmFo5CX9xD3lx5Pp+0+bzLaxkAPaakRsp7r3sQ0TqiRoKPJErDFuhUTCvTRTJDQs3KQx0vLhG5zqSbQVK9/fx7qSHTsAw4luAG5w6fXS7Cdr5Z4c1SAEySWQXrzWkDLFdWeAbX5yEpHx3j6KxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621315; c=relaxed/simple;
	bh=TCxl4wK6+iv2fjiC6DlcgPGZheUWv/KpwdFPy67UhOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVuiq9eBsyXE8RK3kPeWOL+ndPNoCN55RBWJAz6puJ5Po98cRXmlVCSMOnxAF6aa1fWErX1sDLIVVDKHJ/7j0ZGFDlyPcbsji57omTCl/dKLDbx4Lb2ukYjjiLNrMv/QWU5Nu2+Et2qws5mxtnjiiL76DZwHQFasSKPsJKznpZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a1oSt5IT; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a1oSt5IT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d560775ca2so33984365ad.1
        for <audit@vger.kernel.org>; Mon, 24 Aug 2026 18:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621312; cv=none;
        d=google.com; s=arc-20260327;
        b=YOm4Eso/EwshPGFdWYmk/HR49mVsmbN151ft8KAu+wnL/JMjnJ2MsSC1N5ykWh9reA
         Ud4HSoG06UMSOqE1IKk3+yRsRyMyZ4/UFicKxdte1kLW9qBzPo9ShqyfX/tY6bjBvEcF
         Tkn4LOoxyrwcoE1VS8yHKBGuVugL4fUmD54iYobN+0IhAEAicNsD7PRKNUmeJ08AXhsT
         6NeHRlstVYBkfTFbmi7CKJ4T7pU7IaDm1rp/dSljDV6ISiDdnZHhItXgex0cmoGwUcJ+
         y+cdQ/pzyvopZKTxHYnCsusCPeNCsjoN9P2mnYw5uhnYapss+PqYMtrzSEV9IhSpW4e4
         Wm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Khrc5+/AwBjmoKhmPRh84fSbM5f+kuNFaAgwGKJ6x2U=;
        fh=fmb6EqvU5dRimXiogftI/nDLWL61u4n/5se6Wvc9v9g=;
        b=UoJch25aQYCDbPJIQXLCVjyWR67V3S7ivpwAtIyJh0DyT3Ml5VpOdcABwlPz3ieQKg
         bJYJN0BLDnjeU4rrdNq/sV6+rZbUMLWaDdDFN1GhVc5sOIPgLJIDxmlMmt9Eqi+hyrsa
         u1s21dw5ePSC8wBTIPcVMNqbcoMhPUfD7up6bNc0q2CwzefBvxUwIPdf2FUv13XoR7AZ
         jFJk1zR8wtMQ/NjGRAMgXzIq2tU6rOuAmbxMQEOlxPnLjDPUv5mSdFPNdyqLGL0eK/0a
         3sA8dN5ZGQRm7dRs1yBZGrT3J5UQjYX6ZVmTDgek0fUVBaqyVmSBdImLJYMf0w70Re+n
         OQXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787621312; x=1788226112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Khrc5+/AwBjmoKhmPRh84fSbM5f+kuNFaAgwGKJ6x2U=;
        b=a1oSt5ITewkL69yeATDD7tV5vGEVvdfsvDQZ9/NYj4aGPdu6Kvhg6dzQsVcDSrWqEz
         MqXvyGPp7G0tjYvkduaovoOa88gqnWTdJRZFMVPVJGrorm6RLNLht5JXigf6HVC6BZGt
         DyWAm47uFUgxJu43WTntgpAf1HeBaI7lTh7FpgtkN7ct1NhiX89NH2SlIuUJ0JQhgAYD
         ilKLbwVaYhBxCP4CmauXjYqOLCJQgyWFpV8Pv60Dfjr6wmbVaQbt10/nmrXLI9Sn1Z1G
         1E2MprO1ETaSG1dNZMfjpXe1WBp0nBlK7TJ/X6FM5kBp75DO1OK6I9xIGeLnpiyLZw5b
         aCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621312; x=1788226112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Khrc5+/AwBjmoKhmPRh84fSbM5f+kuNFaAgwGKJ6x2U=;
        b=YCmxhujbVygRqeHnUrZD9j8q6ADE1MTYo605FG8b4emX8Si6FCECEYNH/BnoesHTPH
         Cl1+AjifFMQOeZLQ108JquLBxaeFyxCMxYK2M3Iu9W2mnnl0mEM8b7kXBl4955lGEhIh
         0V8XgHdQXq60hYzmv/6zao9ONwN8ZVnDxa3exma4+tUGtOKl+3AeB+Mcu730I0ajN8F6
         Pfgqg1wVDH+1/6SEIiSXHFwqNEf3v5JJGcalQEe2lQRUR8ClNXzbMNnVkIXiBMjeXhJV
         VeQwC66pmoFDJvS95OmjRtOTHftKFDV9RXhg1qlz91eXL43p8SXp8tD/eS8Kwme6YHif
         y1oQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpov49BPzGhLf/HIYjHoer4ZtaSU7HBhplFrPIISYcm+HHz3dKjf5r1fwjnkWUo048d+nrByQ==@vger.kernel.org
X-Gm-Message-State: AFuF++leiODstOmmpu2JomXjYx5qhiTTwgY05RdbENzkI02grlYnrJmW
	Dz0rP7FAr0sQ9wlsIFcxM9Ol+vnFSc9Z1oGzYMFCnLU8e0HeNHkYExBaBF9OIKqiSX56ikgXxar
	3eYWoibnMsX37p3Pgjqa2rQ0UGH1ea91jvd7jt+qLxAXaoJeO0AwbsvvJ
X-Gm-Gg: AR+sD10AZmmYyETwm0ZKZeD/n97Fl87rO+CBxJaUYZNFImlewht8Iaph7cNunuxAV7K
	Ia316GcHmPaHOUHMgmZhYey3KUR5mFbHMexQNVmazYxBlglRePjVsHh80AL7kZ5+jpNEt7haUCq
	pHA0i9sghwFmBv8NVls3X2KzEwDr5NEgAB2deCa1DqK5DYyXFrDlfP2ZPYRDuaVMNykG/yewry8
	Ro691RPzYjN27fEn/VjJTHGA+rtvjT4DOiTISq1VkJqLYksTJzB2RSq3TQFILH/tyvqg9nC57Z0
	vnlq+XHC/3pReAElFrTs9sjQfIGHoIL+wGUatWX6Jp9T
X-Received: by 2002:a17:90b:224a:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-395df677766mr36756196a91.14.1787621312226; Mon, 24 Aug 2026
 18:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814010153.14488-1-include@grrlz.net> <9A205207-E0C7-421F-97D3-D37684F14C09@grrlz.net>
 <CAABTaaCoekpRhmugkNsu+YuAfN9oO4aSZZttW=a_-t_YD1vqNw@mail.gmail.com> <FCD78CD2-B9C0-4B47-872A-C0A2C8611985@grrlz.net>
In-Reply-To: <FCD78CD2-B9C0-4B47-872A-C0A2C8611985@grrlz.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Aug 2026 21:28:19 -0400
X-Gm-Features: AcwNN1XboDrYQgBiWC_fdS4mmrmRk08jX3WhQy5RVPkHtQYlr7l5bYfNvR18LyM
Message-ID: <CAHC9VhRXv-XYbnrs6CkqnvE=P3swHvO1d1m_-Vk0G0KFFPn0dA@mail.gmail.com>
Subject: Re: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() to
 send time
To: Bradley Morgan <include@grrlz.net>
Cc: Ricardo Robaina <rrobaina@redhat.com>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:38=E2=80=AFPM Bradley Morgan <include@grrlz.net>=
 wrote:
> On 20 August 2026 16:57:12 BST, Ricardo Robaina <rrobaina@redhat.com>
> wrote:

...

> >Hi Bradley,
> >
> >Paul will probably explain better, but see the seesion "Don=E2=80=99t ge=
t
> >discouraged - or impatient" in [1], in the meantime. There was a merge
> >window going on recently.
>
> This ignoring seems to be a deliberate thing, NOTE THAT THAT WAS MY FIRST
> PATCH ever after studying for god knows how long. I have the right to be
> annoyed

You've already seen my feedback on this patch, and it sounds like we
are in agreement as to why it would be a step backward, but I wanted
to comment quickly on this other aspect of the thread.

As Ricardo already pointed out, this patch was posted during an
awkward period when the audit/dev branch was only open to critical
fixes.  If you haven't already seen it via the audit MAINTAINERS
entry, we have a document describing how the audit tree is managed and
some of the basic processes, a link is below:

https://github.com/linux-audit/audit-kernel/blob/main/README.md

It's also important to note that many Open Source maintainers have
been under a lot of pressure lately due to a significant increase in
reported bugs/vulnerabilities from LLM-based bug hunters.  For obvious
reasons, not all of these reports are public, but I think it's safe to
say that any maintainer of software with more than a few users is
dealing with these reports.

--
paul-moore.com
