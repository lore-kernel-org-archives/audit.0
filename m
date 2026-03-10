Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ACF350A3A
	for <audit@vger.kernel.org>; Tue, 10 Mar 2026 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170705; cv=none; b=EVMh3sx2+I8n3+WRHBQLB5SGNWUfYUd+r3UnI6M8mZB3eJcH9j+9nBdxO7poG7f7L/I6iNUlxZ7gkgSRcJGcBkGaJBR2O66fWnzmnvUvWhAGKCd8usD3QSXBBpSA3xWCzKmjQNVTZFRUh81UbuwE2Y3yreCZPF0hOZK3vBO8x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170705; c=relaxed/simple;
	bh=isqto//eT7kuNMSwK/zpsf/g/J2I3ulyzlZ9kDJl2nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjF4MPEBErE936FegcWmUd8m1VBjtahZn/ko/lUTGppeZ5QKzkTeViG+7EVGi+3aFjxwNJFWQ/mzrn5qSbkspt2A2j7EUrbSM6L78COJlYgDLLEM3QAWuL9OMkQkGorbxYybAq2nGBDvRzOb3ksXRqqyllu7LfgS/VxSHyxfFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWPwDLeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWPwDLeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773170703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzs0Gj9KFXKBBfkbW0fr/mUDW3TamTxxkb4puzXZyKY=;
	b=MWPwDLeTqoEIThSVkYMin6+baT6TPY8bRtXNQlWVfaORq8D2FCWPqlxtAuEfWdrNH78GkD
	4l6pz9POVFkW2X7ZAqn+Mr4YrkVZaGdOzBfmEaJgf4Y0pkD4XNuNtl3l0YNxs1RZQB+qaI
	PDcs/O7IqL22JcFW4AE2+hOuuGAaXv0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-_Tr7VQdYMgWUVYS3dJdORA-1; Tue, 10 Mar 2026 15:24:59 -0400
X-MC-Unique: _Tr7VQdYMgWUVYS3dJdORA-1
X-Mimecast-MFC-AGG-ID: _Tr7VQdYMgWUVYS3dJdORA_1773170698
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-662a61be7a5so1961324a12.3
        for <audit@vger.kernel.org>; Tue, 10 Mar 2026 12:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773170698; x=1773775498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzs0Gj9KFXKBBfkbW0fr/mUDW3TamTxxkb4puzXZyKY=;
        b=T0oP451c2sDVuiJ420QY2ufw+67vQnN16hHYwRm/l/nvqHWzROtBJofpxR2C2rDnye
         xS8RlLdcYXH3BjGaP+QnFkSkAFBvsobpePv468UQ/0rM/Vt4S7IdvV/Ik+1Ul6KFKpyq
         sQv5pg76xCwL1sCx2r3jknVgHd4prl3+lPBRMG5igxtYaUe5uIygwcpZMGAYjiYMaCmv
         kWia1fskSYqcJM/OgZNWjpyXSUdCRslb340gKjm7w5JAaHKXORpgPS4Bd/PyuCErG7Xv
         niU1ryEy3UoUNA+Ep16JtLsXzrZ6ReegzDnAw475i8mX84jkuK9zJLENR+6tMRiNEzPu
         IhDA==
X-Gm-Message-State: AOJu0YwXLJRBpbTqFAsk9YoV60XKrA3k6zgpE/LcDGyMoShzs8q0Mie4
	4JUMhjaix+0jCGGA+LXKRWISxPoPHgqi7RvPsY0g6jrLiBBwvcRRH0R6h/opcpzoN+2hsifW6tC
	/CyWctNmT1rmaPYzaCca4vPKDV4eC+jjNKrq6tYQj6MjD2EydGwTmUhM2i9QlN+9tOoX6BLTeDn
	B5vjUddEvSoaXJMefGYfTvaeftYjhkdKo=
X-Gm-Gg: ATEYQzxlbi+Gpg8J4BRv6hGom23vYrq42Ffh1K99+ExwACGyiIf7o/9a0GBXml0rzlz
	Hx469Ea9GXpcHav+2xIJIUS0ymfR22QBlxtuhMwdYQ+vMXMvqWIXMXXhBzC7cYbSXVm/OIk4pBd
	oJ8KN4H6WBsmiCYsO1JiysLOMdFiM2OYZJ7PGPNI0ZEDg2vWAkaonlPyKywAnn8VumYYM9HolRq
	AcqgR9dezXhWB/1ervT/VZ8LnlgsiyXLWOVf2tciRD0jqfNyRn75PcagmNxfRQHKERYia62DwAX
	boing3Ptojn93EONpgY9xWw=
X-Received: by 2002:a17:906:9f84:b0:b8f:a5c8:f83 with SMTP id a640c23a62f3a-b942dbaa164mr844547566b.23.1773170698090;
        Tue, 10 Mar 2026 12:24:58 -0700 (PDT)
X-Received: by 2002:a17:906:9f84:b0:b8f:a5c8:f83 with SMTP id
 a640c23a62f3a-b942dbaa164mr844546166b.23.1773170697691; Tue, 10 Mar 2026
 12:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309130533.158095-1-rrobaina@redhat.com> <7e02e707baecb7c94db329d5d03c1c15@paul-moore.com>
In-Reply-To: <7e02e707baecb7c94db329d5d03c1c15@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 10 Mar 2026 16:24:46 -0300
X-Gm-Features: AaiRm53iedKs1QjjpOy2o-_L1h1LH00Wtkg_jP8jOY_eiWlPyLtooi8XB6QPGeo
Message-ID: <CAABTaaDdpzxwx9SDTivA=MvdeiZX0A5brC6qQffJiEDUYMX+XQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: handle unknown status requests in audit_receive_msg
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	Steve Grubb <sgrubb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F4Ba4dsd-AJCbAzPa7-C78D83Gt-7_XV9PZaeuwNUnA_1773170698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 4:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mar  9, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
> > requests, incorrectly returning success to newer user space tools
> > querying unsupported features. This breaks forward compatibility.
> >
> > Fix this by defining AUDIT_STATUS_ALL and returning -EINVAL if any
> > unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
> > This ensures invalid requests are safely rejected, allowing user space
> > to reliably test for and gracefully handle feature detection on older
> > kernels.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> > v1 -> v2:
> >  - Moved AUDIT_STATUS_ALL from include/uapi/linux/audit.h to
> >    include/linux/audit.h.
> >
> >  include/linux/audit.h | 9 +++++++++
> >  kernel/audit.c        | 2 ++
> >  2 files changed, 11 insertions(+)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!

